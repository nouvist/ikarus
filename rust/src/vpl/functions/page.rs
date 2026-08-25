use std::sync::Arc;

use async_trait::async_trait;
use chromiumoxide::Page;
use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::{
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

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallPageWaitForNavigation {
    pub page: Value,
    pub url: Value,
}

#[async_trait]
impl Invoke for FnCallPageWaitForNavigation {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let pointer = self.page.unwrap_as_identifier("Halaman")?;
        let pointer = interpreter.unwrap_pointer::<Page>(pointer)?;
        pointer.wait_for_navigation().await?;

        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallPageFindElement {
    pub page: Value,
    pub element: Value,
    pub selector: Value,
}

#[async_trait]
impl Invoke for FnCallPageFindElement {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let page = self.page.unwrap_as_identifier("Halaman")?;
        let element = self.element.unwrap_as_identifier("Element")?;
        let page = interpreter.unwrap_pointer::<Page>(page)?;
        let selector = self.selector.unwrap_as_string("Pemilah")?;

        let value = page.find_element(selector.0.to_owned()).await.ok();
        match value {
            Some(it) => {
                interpreter.store_variable(element, &element::symbol())?;
                interpreter.store_pointer(element.0.clone(), Arc::new(it));
            }
            None => {
                interpreter.store_variable(element, &Value::Null)?;
            }
        }

        Ok(())
    }
}
