use flutter_rust_bridge::frb;
use rmcp::{ErrorData, handler::server::wrapper::Parameters, tool, tool_router};
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::{
    shared::error_helper::MapKnownError,
    vpl::{
        binding::RawScopeBinding,
        raw_tokens::{RawScope, RawStatement},
    },
};

#[frb(ignore)]
#[derive(Clone)]
pub struct McpServer {}

#[tool_router(server_handler)]
impl McpServer {
    #[tool(description = "Get current statements")]
    async fn get_statements(&self) -> Result<String, ErrorData> {
        let current = RawScopeBinding::current().await;
        let json = serde_json::to_string(&current).map_known_error()?;
        Ok(json)
    }

    #[tool(description = "Add new statement")]
    async fn add_statement(
        &self,
        Parameters(param): Parameters<McpAddStatement>,
    ) -> Result<String, ErrorData> {
        let mut current = RawScopeBinding::current().await.0;
        current.insert(
            param
                .index
                .unwrap_or_else(|| current.len())
                .clamp(0, current.len()),
            param.statement,
        );
        RawScopeBinding::update(RawScope(current)).await;

        Ok("success".to_string())
    }
}

#[frb(ignore)]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct McpAddStatement {
    pub statement: RawStatement,
    pub index: Option<usize>,
}
