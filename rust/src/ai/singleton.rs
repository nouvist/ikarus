use std::sync::Arc;

use flutter_rust_bridge::{DartFnFuture, frb};
use rig::{client::AgentClientExt, providers::openai};
use rmcp::{RoleClient, ServiceExt, model::Tool, service::RunningService};
use tokio::{
    io,
    sync::{OnceCell, RwLock},
};

use crate::{
    ai::{
        mcp::McpServer,
        state::{AiState, AiStateAnswer, AiStatePlan, AiStateStart, AiStateStartDecision},
    },
    impl_frb_clone,
    shared::{error::Error, error_helper::MapError, settings::Settings},
    vpl::binding::RawScopeBinding,
};

#[frb(ignore)]
#[derive(Clone)]
pub struct AiSingletonInner {
    settings: Settings,
    client: openai::Client,
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

        Ok(Self {
            inner: Arc::new(RwLock::new(AiSingletonInner { settings, client })),
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
        cb: impl Fn(AiState) -> DartFnFuture<()>,
    ) -> Result<(), Error> {
        let context = format!("#Program:\n{}", RawScopeBinding::current().await.to_json()?,);
        let inner = self.inner.read().await;
        let model = &inner.settings.text_generation_model;
        let client = &inner.client;
        let extractor_start = client
            .extractor::<AiStateStart>(model.to_owned())
            .preamble(concat!(
                include_str!("./prompts/preamble.md"),
                include_str!("./prompts/ai_state_start.md"),
            ))
            .build();
        let extractor_answer = client
            .extractor::<AiStateAnswer>(model.to_owned())
            .preamble(include_str!("./prompts/preamble.md"))
            .context(&context)
            .build();
        let extractor_plan = client
            .extractor::<AiStatePlan>(model.to_owned())
            .preamble(concat!(
                include_str!("./prompts/preamble.md"),
                include_str!("./prompts/ai_state_plan.md"),
            ))
            .context(&context)
            .build();

        let start = extractor_start.extract(prompt.clone()).await?;
        (cb)(AiState::Start(start.clone())).await;

        if let AiStateStartDecision::AnswerImmediately = start.decision {
            let answer = extractor_answer
                .extract(format!("{}{}", prompt, prompt.clone()))
                .await?;
            (cb)(AiState::Answer(answer)).await;
            return Ok(());
        }

        let plan = extractor_plan.extract(prompt.clone()).await?;
        (cb)(AiState::Plan(plan.clone())).await;

        Ok(())
    }
}
