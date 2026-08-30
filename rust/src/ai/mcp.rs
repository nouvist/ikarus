use flutter_rust_bridge::frb;
use rmcp::{ErrorData, handler::server::wrapper::Parameters, tool, tool_router};
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};
use serde_json::json;

use crate::{
    browser::singleton::BrowserSingleton,
    shared::{
        error::Error,
        error_helper::{MapKnownError, OkOrError},
    },
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
    #[tool(description = "[VPL] Get current statements")]
    async fn vpl_get_statements(&self) -> Result<String, ErrorData> {
        let current = RawScopeBinding::current().await;
        let json = serde_json::to_string(&current).map_known_error()?;
        Ok(json)
    }

    #[tool(description = "[VPL] Add new statement")]
    async fn vpl_add_statement(
        &self,
        Parameters(param): Parameters<McpVplAddStatement>,
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

    #[tool(description = "[VPL] Replace statement")]
    async fn vpl_replace_statement(
        &self,
        Parameters(param): Parameters<McpVplReplaceStatement>,
    ) -> Result<String, ErrorData> {
        let mut current = RawScopeBinding::current().await.0;
        current.remove(param.index);
        current.insert(param.index, param.statement);
        RawScopeBinding::update(RawScope(current)).await;
        Ok("success".to_string())
    }

    #[tool(description = "[VPL] Remove statement")]
    async fn vpl_remove_statement(
        &self,
        Parameters(param): Parameters<McpVplRemoveStatement>,
    ) -> Result<String, ErrorData> {
        let mut current = RawScopeBinding::current().await.0;
        current.remove(param.index);
        RawScopeBinding::update(RawScope(current)).await;
        Ok("success".to_string())
    }

    #[tool(description = "[Browser] Get current opened tab urls")]
    async fn browser_get_urls(&self) -> Result<String, ErrorData> {
        let browser = BrowserSingleton::instance().lock().await;
        let browser = browser.browser()?;
        let pages = browser.pages().await.map_known_error()?;
        let mut vec = Vec::<Option<String>>::with_capacity(pages.len());
        for page in pages {
            let url = page.url().await.map_known_error()?;
            vec.push(url);
        }
        Ok(serde_json::to_string(&vec).map_known_error()?)
    }

    #[tool(description = "[Browser] Open new tab")]
    async fn browser_new(
        &self,
        Parameters(param): Parameters<McpBrowserNew>,
    ) -> Result<String, ErrorData> {
        let browser = BrowserSingleton::instance().lock().await;
        let browser = browser.browser()?;
        let page = browser.new_page(param.url).await.map_known_error()?;
        let mut index = 0usize;
        for it in browser.pages().await.map_known_error()? {
            match it.target_id() == page.target_id() {
                true => break,
                false => {
                    index += 1;
                }
            }
        }

        Ok(json!({"index": index}).to_string())
    }

    #[tool(description = "[Browser] Open new tab")]
    async fn browser_get_html(
        &self,
        Parameters(param): Parameters<McpBrowserGetHtml>,
    ) -> Result<String, ErrorData> {
        let browser = BrowserSingleton::instance().lock().await;
        let browser = browser.browser()?;
        let pages = browser.pages().await.map_known_error()?;
        let page = pages.get(param.tab).ok_or_browser_tab_not_found()?;
        let html = page.content().await.map_known_error()?;
        Ok(html)
    }
}

#[frb(ignore)]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
struct McpVplAddStatement {
    pub statement: RawStatement,
    pub index: Option<usize>,
}

#[frb(ignore)]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
struct McpVplReplaceStatement {
    pub statement: RawStatement,
    pub index: usize,
}

#[frb(ignore)]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct McpVplRemoveStatement {
    pub index: usize,
}

#[frb(ignore)]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
struct McpBrowserNew {
    pub url: String,
}

#[frb(ignore)]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
struct McpBrowserGetHtml {
    pub tab: usize,
}
