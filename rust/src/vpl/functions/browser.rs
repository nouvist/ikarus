use std::sync::Arc;

use async_trait::async_trait;
use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::{
    browser::singleton::BrowserSingleton,
    shared::{
        error::Error,
        error_helper::{MapError, OkOrError},
    },
    vpl::{
        extensions::ValueUnwrapAsIdentifier,
        functions::{Invoke, page},
        interpreter::Interpreter,
        tokens::{Value, ValueNumber},
    },
};

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallBrowserNewPage {
    pub page: Value,
    pub url: Value,
}

#[async_trait]
impl Invoke for FnCallBrowserNewPage {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let pointer = &self.page.unwrap_as_identifier()?;
        let url = interpreter.evaluate_variable(&self.url)?;
        let url = url
            .as_string()
            .ok_or_function_invalid_argument("Url harus berupa string")?;

        let singleton = BrowserSingleton::instance().lock().await;
        let browser = singleton.browser()?;
        let page = browser.new_page(&url.0).await.map_browser_invalid_url()?;

        interpreter.store_variable(pointer, &page::symbol())?;
        interpreter.store_pointer(pointer.0.clone(), Arc::new(page));

        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallBrowserGetPageCount {
    pub result: Value,
}

#[async_trait]
impl Invoke for FnCallBrowserGetPageCount {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let result = self.result.unwrap_as_identifier()?;
        let singleton = BrowserSingleton::instance().lock().await;
        let browser = singleton.browser()?;
        let pages = browser.pages().await?;
        let value = Value::Number(ValueNumber(pages.len() as f64));

        interpreter.store_variable(result, &value)?;
        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallBrowserGetPage {
    pub page: Value,
    pub index: Value,
}

#[async_trait]
impl Invoke for FnCallBrowserGetPage {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let ident = self.page.unwrap_as_identifier()?;
        let index = interpreter.evaluate_variable(&self.index)?;
        let index = index
            .as_number()
            .ok_or_function_invalid_argument("Url harus berupa string")?;
        let index = index.0 as usize;

        let singleton = BrowserSingleton::instance().lock().await;
        let browser = singleton.browser()?;
        let pages = browser.pages().await?;
        let Some(page) = pages.get(index).map(|it| it.clone()) else {
            interpreter.store_variable(ident, &Value::Null)?;
            return Ok(());
        };

        interpreter.store_variable(ident, &page::symbol())?;
        interpreter.store_pointer(ident.0.clone(), Arc::new(page));

        Ok(())
    }
}
