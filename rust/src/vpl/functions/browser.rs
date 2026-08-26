use std::sync::Arc;

use async_trait::async_trait;
use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::{
    browser::singleton::BrowserSingleton,
    shared::{error::Error, error_helper::MapError},
    vpl::{
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
        let page_ptr = &self.page.unwrap_as_identifier("Halaman")?;
        let url = interpreter.evaluate_variable(&self.url)?;
        let url = url.unwrap_as_string("Url")?;

        let singleton = BrowserSingleton::instance().lock().await;
        let browser = singleton.browser()?;
        let value = browser.new_page(&url.0).await.map_browser_invalid_url()?;

        interpreter.store_variable(page_ptr, &page::symbol())?;
        interpreter.store_pointer(page_ptr.0.clone(), Arc::new(value));

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
        let result_ptr = self.result.unwrap_as_identifier("Halaman")?;
        let singleton = BrowserSingleton::instance().lock().await;
        let browser = singleton.browser()?;
        let pages = browser.pages().await?;
        let value = Value::Number(ValueNumber(pages.len() as f64));

        interpreter.store_variable(result_ptr, &value)?;
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
        let page_ptr = self.page.unwrap_as_identifier("Halaman")?;
        let index = interpreter.evaluate_variable(&self.index)?;
        let index = index.unwrap_as_number("Indeks")?;
        let index = index.0 as usize;

        let singleton = BrowserSingleton::instance().lock().await;
        let browser = singleton.browser()?;
        let pages = browser.pages().await?;
        let Some(page) = pages.get(index).map(|it| it.clone()) else {
            interpreter.store_variable(page_ptr, &Value::Null)?;
            return Ok(());
        };

        interpreter.store_variable(page_ptr, &page::symbol())?;
        interpreter.store_pointer(page_ptr.0.clone(), Arc::new(page));

        Ok(())
    }
}
