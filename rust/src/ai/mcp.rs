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
        let index = param
            .index
            .unwrap_or_else(|| current.len())
            .clamp(0, current.len());

        current.insert(index, param.statement);
        RawScopeBinding::update(RawScope(current)).await;

        Ok("success".to_string())
    }

    #[tool(description = "Replace statement")]
    async fn replace_statement(&self, Parameters(param): Parameters<McpReplaceStatement>) {
        let mut current = RawScopeBinding::current().await.0;
        current.remove(param.index);
        current.insert(param.index, param.statement);
        RawScopeBinding::update(RawScope(current)).await;
    }

    #[tool(description = "Remove statement")]
    async fn remove_statement(&self, Parameters(param): Parameters<McpRemoveStatement>) {
        let mut current = RawScopeBinding::current().await.0;
        current.remove(param.index);
        RawScopeBinding::update(RawScope(current)).await;
    }
}

#[frb(ignore)]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct McpAddStatement {
    pub statement: RawStatement,
    pub index: Option<usize>,
}

#[frb(ignore)]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct McpReplaceStatement {
    pub statement: RawStatement,
    pub index: usize,
}

#[frb(ignore)]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct McpRemoveStatement {
    pub index: usize,
}
