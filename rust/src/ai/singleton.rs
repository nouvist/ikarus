use flutter_rust_bridge::frb;
use rig::{client::AgentClientExt, providers::openai};
use rmcp::{RoleClient, ServiceExt, model::Tool, service::RunningService};
use tokio::io;

use crate::{
    ai::mcp::McpServer,
    shared::{
        abort_controller::AbortController,
        error::Error,
        error_helper::{MapError, OkOrError},
        settings::Settings,
        templates::preamble_md,
    },
};

#[frb(opaque)]
pub struct AiSingleton {
    settings: Settings,
}

impl AiSingleton {
    pub async fn initialize(settings: Settings, abort: AbortController) -> Result<(), Error> {
        let (mcp_client, mcp_tools) = Self::mcp(abort.clone()).await?;
        let client = openai::Client::builder()
            .base_url(settings.text_generation_url)
            .api_key(settings.text_generation_key)
            .build()
            .map_ai_failed_to_initialize()?;

        let agent = client
            .agent(settings.text_generation_model)
            .preamble(preamble_md())
            .rmcp_tool(
                mcp_tools.first().ok_or_ai_failed_to_initialize()?.clone(),
                mcp_client.peer().clone(),
            );
        Ok(())
    }

    async fn mcp(
        abort: AbortController,
    ) -> Result<(RunningService<RoleClient, ()>, Vec<Tool>), Error> {
        let (client_io, server_io) = io::duplex(1024 * 6);
        tokio::spawn(async move {
            let server = McpServer {};
            _ = abort.run_until_cancelled(server.serve(server_io)).await;
        });

        let client = ().serve(client_io).await.map_ai_failed_to_initialize()?;
        let tools = client
            .peer()
            .list_all_tools()
            .await
            .map_ai_failed_to_initialize()?;
        Ok((client, tools))
    }
}
