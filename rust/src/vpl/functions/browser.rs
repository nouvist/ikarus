use async_trait::async_trait;
use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::{
    browser::singleton::BrowserSingleton,
    error::Error,
    vpl::{
        functions::Invoke,
        interpreter::Interpreter,
        tokens::{Value, ValueObject},
    },
};

fn symbol_page() -> Value {
    Value::Object(ValueObject {
        symbol: "[Objek Halaman]".to_owned(),
    })
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallBrowserNewPage {
    pub variable: Value,
    pub url: Value,
}

#[async_trait]
impl Invoke for FnCallBrowserNewPage {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let variable = &self
            .variable
            .as_identifier()
            .ok_or_else(|| Error::FunctionInvalidArgument("Variabel harus berupa rujukan"))?;
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

        interpreter.store_pointer(variable.0.clone(), Box::new(page));
        interpreter.store_variable(variable, &symbol_page())?;

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
        let variable = &self
            .variable
            .as_identifier()
            .ok_or_else(|| Error::FunctionInvalidArgument("Variabel harus berupa rujukan"))?;
        let index = interpreter.evaluate_variable(&self.index)?;
        let index = index
            .as_number()
            .ok_or_else(|| Error::FunctionInvalidArgument("Url harus berupa string"))?;
        let index = index.0 as usize;

        let singleton = BrowserSingleton::instance().inner().await;
        let browser = singleton.browser()?;
        let pages = browser.pages().await?;
        let Some(page) = pages.get(index).map(|it| it.clone()) else {
            interpreter.store_variable(variable, &Value::Null)?;
            return Ok(());
        };

        interpreter.store_pointer(variable.0.clone(), Box::new(page));
        interpreter.store_variable(variable, &symbol_page())?;

        Ok(())
    }
}
