use std::sync::Arc;

use async_trait::async_trait;
use chromiumoxide::Page;
use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::{
    shared::{error::Error, error_helper::OkOrError},
    vpl::{
        extensions::ValueUnwrapAsIdentifier,
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
        let pointer = self.page.unwrap_as_identifier()?;
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
        let pointer = self.page.unwrap_as_identifier()?;
        let element_ident = self.element.unwrap_as_identifier()?;
        let pointer = interpreter.unwrap_pointer::<Page>(pointer)?;
        let selector = self
            .selector
            .as_string()
            .ok_or_function_invalid_argument("Pemilah harus berupa string")?;

        let element = pointer.find_element(selector.0.to_owned()).await.ok();
        println!("{element:?}");
        match element {
            Some(it) => {
                interpreter.store_variable(element_ident, &element::symbol())?;
                interpreter.store_pointer(element_ident.0.clone(), Arc::new(it));
            }
            None => {
                interpreter.store_variable(element_ident, &Value::Null)?;
            }
        }

        Ok(())
    }
}
