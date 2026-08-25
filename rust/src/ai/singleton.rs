use std::sync::Arc;

use flutter_rust_bridge::frb;
use rig::{Agent, client::AgentClientExt, providers::openai};
use rmcp::{RoleClient, ServiceExt, model::Tool, service::RunningService};
use tokio::{
    io,
    sync::{OnceCell, RwLock},
};

use crate::{
    ai::mcp::McpServer,
    impl_frb_clone,
    shared::{
        error::Error,
        error_helper::{MapError, OkOrError},
        settings::Settings,
        templates::preamble_md,
    },
};

#[frb(ignore)]
#[derive(Clone)]
pub struct AiSingletonInner {
    settings: Settings,
    agent: Agent,
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
        let (mcp_client, mcp_tools) = Self::initialize_mcp().await?;
        let agent = Self::initialize_agent(&settings, &mcp_client, &mcp_tools).await?;

        Ok(Self {
            inner: Arc::new(RwLock::new(AiSingletonInner {
                settings: settings,
                agent: agent,
            })),
        })
    }

    async fn initialize_agent(
        settings: &Settings,
        mcp_client: &RunningService<RoleClient, ()>,
        mcp_tools: &Vec<Tool>,
    ) -> Result<Agent, Error> {
        let client = openai::Client::builder()
            .base_url(&settings.text_generation_url)
            .api_key(&settings.text_generation_key)
            .build()
            .map_ai_failed_to_initialize()?;

        let agent = client
            .agent(&settings.text_generation_model)
            .preamble(preamble_md())
            .rmcp_tool(
                mcp_tools.first().ok_or_ai_failed_to_initialize()?.clone(),
                mcp_client.peer().clone(),
            )
            .build();

        Ok(agent)
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
}
