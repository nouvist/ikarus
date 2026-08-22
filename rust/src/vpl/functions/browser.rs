use async_trait::async_trait;
use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::{
    browser::singleton::BrowserSingleton,
    error::Error,
    vpl::{
        extensions::ValueUnwrapAsIdentifier,
        functions::{Invoke, page},
        interpreter::Interpreter,
        tokens::Value,
    },
};

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallBrowserNewPage {
    pub variable: Value,
    pub url: Value,
}

#[async_trait]
impl Invoke for FnCallBrowserNewPage {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let ident = &self.variable.unwrap_as_identifier()?;
        let url = interpreter.evaluate_variable(&self.url)?;
        let url = url
            .as_string()
            .ok_or_else(|| Error::FunctionInvalidArgument("Url harus berupa string"))?;

        let singleton = BrowserSingleton::instance().inner().await;
        let browser = singleton.browser()?;
        let page = browser
            .new_page(&url.0)
            .await
            .map_err(|_| Error::BrowserInvalidUrl)?;

        interpreter.store_pointer(ident.0.clone(), Box::new(page));
        interpreter.store_variable(ident, &page::symbol())?;

        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallBrowserGetPage {
    pub variable: Value,
    pub index: Value,
}

#[async_trait]
impl Invoke for FnCallBrowserGetPage {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let ident = self.variable.unwrap_as_identifier()?;
        let index = interpreter.evaluate_variable(&self.index)?;
        let index = index
            .as_number()
            .ok_or_else(|| Error::FunctionInvalidArgument("Url harus berupa string"))?;
        let index = index.0 as usize;

        let singleton = BrowserSingleton::instance().inner().await;
        let browser = singleton.browser()?;
        let pages = browser.pages().await?;
        let Some(page) = pages.get(index).map(|it| it.clone()) else {
            interpreter.store_variable(ident, &Value::Null)?;
            return Ok(());
        };

        interpreter.store_pointer(ident.0.clone(), Box::new(page));
        interpreter.store_variable(ident, &page::symbol())?;

        Ok(())
    }
}
