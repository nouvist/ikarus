use std::sync::Arc;

use async_trait::async_trait;
use chromiumoxide::Page;
use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::{
    browser::singleton::BrowserSingleton,
    shared::error::Error,
    vpl::{
        functions::{Invoke, element},
        interpreter::Interpreter,
        tokens::{Value, ValueObject},
    },
};

pub fn symbol() -> Value {
    Value::Object(ValueObject {
        symbol: "[Objek Halaman]".to_owned(),
    })
}

#[frb(non_opaque)]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallPageWaitForNavigation {
    pub page: Value,
    pub url: Value,
}

#[async_trait]
impl Invoke for FnCallPageWaitForNavigation {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let page_ptr = self.page.unwrap_as_identifier("Halaman")?;
        let page = interpreter.unwrap_pointer::<Page>(page_ptr)?;
        page.wait_for_navigation().await?;

        Ok(())
    }
}

#[frb(non_opaque)]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallPageClose {
    pub page: Value,
    pub url: Value,
}

#[async_trait]
impl Invoke for FnCallPageClose {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let page_ptr = self.page.unwrap_as_identifier("Halaman")?;
        let page = interpreter.unwrap_pointer::<Page>(page_ptr)?;
        let singleton = BrowserSingleton::instance().lock().await;
        let browser = singleton.browser()?;
        let pages = browser.pages().await?;
        let page = pages
            .into_iter()
            .find(|it| it.target_id() == page.target_id());
        if let Some(page) = page {
            page.close().await?;
        }

        interpreter.remove_pointer("Halaman");
        interpreter.remove_variable("Halaman");

        Ok(())
    }
}

#[frb(non_opaque)]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallPageFindElement {
    pub page: Value,
    pub element: Value,
    pub selector: Value,
}

#[async_trait]
impl Invoke for FnCallPageFindElement {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let page_ptr = self.page.unwrap_as_identifier("Halaman")?;
        let page = interpreter.unwrap_pointer::<Page>(page_ptr)?;
        let element_ptr = self.element.unwrap_as_identifier("Element")?;
        let selector = self.selector.unwrap_as_string("Pemilah")?;

        let value = page.find_element(selector.0.to_owned()).await.ok();
        match value {
            Some(it) => {
                interpreter.store_variable(element_ptr, &element::symbol())?;
                interpreter.store_pointer(element_ptr.0.clone(), Arc::new(it));
            }
            None => {
                interpreter.store_variable(element_ptr, &Value::Null)?;
            }
        }

        Ok(())
    }
}
