use std::{borrow::Cow, sync::Arc};

use flutter_rust_bridge::{DartFnFuture, frb};
use rig::{
    agent::MultiTurnStreamItem,
    client::AgentClientExt,
    message::{Message, ToolChoice},
    providers::openai,
    streaming::{StreamedAssistantContent, StreamingChat},
};
use rmcp::{RoleClient, ServiceExt, model::Tool, service::RunningService};
use tokio::{
    io,
    sync::{OnceCell, RwLock},
};
use tokio_stream::StreamExt;

use crate::{
    ai::mcp::McpServer,
    impl_frb_clone,
    shared::{error::Error, error_helper::MapError, settings::Settings},
};

#[frb(ignore)]
pub struct AiSingletonInner {
    settings: Settings,
    client: openai::Client,
    mcp_client: RunningService<RoleClient, ()>,
    mcp_tools: Vec<Tool>,
}

#[frb(opaque)]
#[derive(Clone)]
pub struct AiSingleton {
    inner: Arc<RwLock<AiSingletonInner>>,
}
impl_frb_clone!(AiSingleton);

impl AiSingleton {
    pub async fn frb_override_instance() -> Result<Self, Error> {
        Ok(Self::instance().await?.clone())
    }

    pub async fn instance() -> Result<&'static Self, Error> {
        static INSTANCE: OnceCell<AiSingleton> = OnceCell::const_new();
        INSTANCE.get_or_try_init(Self::initialize).await
    }

    async fn initialize() -> Result<Self, Error> {
        let settings = Settings::current().await;
        let client = Self::initialize_client(&settings).await?;
        let (mcp_client, mcp_tools) = Self::initialize_mcp().await?;

        Ok(Self {
            inner: Arc::new(RwLock::new(AiSingletonInner {
                settings,
                client,
                mcp_client,
                mcp_tools,
            })),
        })
    }

    async fn initialize_client(settings: &Settings) -> Result<openai::Client, Error> {
        let client = openai::Client::builder()
            .base_url(&settings.text_generation_url)
            .api_key(&settings.text_generation_key)
            .build()
            .map_ai_failed_to_initialize()?;

        Ok(client)
    }

    async fn initialize_mcp() -> Result<(RunningService<RoleClient, ()>, Vec<Tool>), Error> {
        let (client_io, server_io) = io::duplex(1024 * 6);
        tokio::spawn(async move {
            let server = McpServer {};
            let result = server.serve(server_io).await.unwrap();
            result.waiting().await
        });

        let client = ().serve(client_io).await;
        let client = client.map_ai_failed_to_initialize()?;
        let tools = client
            .peer()
            .list_all_tools()
            .await
            .map_ai_failed_to_initialize()?;
        Ok((client, tools))
    }

    pub async fn prompt(
        &self,
        prompt: String,
        history: Vec<AiHistory>,
        cb: impl Fn(AiResponse) -> DartFnFuture<()>,
    ) -> Result<(), Error> {
        let inner = self.inner.read().await;
        let model = &inner.settings.text_generation_model;
        let client = &inner.client;
        let mcp_client = &inner.mcp_client;
        let mcp_tools = &inner.mcp_tools;

        let agent = client
            .agent(model)
            .preamble(include_str!("./prompts/preamble.md"))
            .rmcp_tools(mcp_tools.to_vec(), mcp_client.peer().clone())
            .tool_choice(ToolChoice::Auto)
            .default_max_turns(100)
            .build();

        let history = history.iter().map(|it| match it {
            AiHistory::Assistant(it) => Message::assistant(it),
            AiHistory::User(it) => Message::user(it),
        });

        let mut stream = agent.stream_chat(prompt, history).await;
        while let Some(next) = stream.next().await {
            let next = next?;
            match next {
                MultiTurnStreamItem::StreamAssistantItem(it) => match it {
                    StreamedAssistantContent::Text(text) => {
                        (cb)(AiResponse::Response(text.text)).await
                    }
                    _ => continue,
                },
                MultiTurnStreamItem::ToolExecutionCommitted { tool_call, .. } => {
                    (cb)(AiResponse::Tool(
                        Self::map_tool(&tool_call.function.name).to_string(),
                    ))
                    .await;
                }
                _ => continue,
            }
        }

        Ok(())
    }

    fn map_tool(tool: &str) -> Cow<'static, str> {
        match tool {
            "vpl_get_statements" => Cow::Borrowed("Membaca program saat ini"),
            "vpl_add_statement" => Cow::Borrowed("Menambahkan balok kode"),
            "vpl_replace_statement" => Cow::Borrowed("Mengganti balok kode"),
            "vpl_remove_statement" => Cow::Borrowed("Menghapus balok kode"),
            "browser_get_urls" => Cow::Borrowed("Melihat tab pada peramban"),
            "browser_new" => Cow::Borrowed("Membuat tab baru"),
            "browser_get_html" => Cow::Borrowed("Melihat isi tab"),
            it => Cow::Owned(it.to_owned()),
        }
    }
}

#[frb(non_opaque)]
pub enum AiHistory {
    Assistant(String),
    User(String),
}

#[frb(non_opaque)]
pub enum AiResponse {
    Tool(String),
    Response(String),
}
