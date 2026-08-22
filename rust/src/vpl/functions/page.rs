use async_trait::async_trait;
use chromiumoxide::Page;
use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::{
    error::Error,
    vpl::{
        extensions::{IdentifierUnwrapPointer, ValueUnwrapAsIdentifier},
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
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallPageWaitForNavigation {
    pub page: Value,
    pub url: Value,
}

#[async_trait]
impl Invoke for FnCallPageWaitForNavigation {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let ident = self.page.unwrap_as_identifier()?;
        let page = ident.unwrap_pointer::<Page>(interpreter)?;
        page.wait_for_navigation().await?;

        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallPageFindElement {
    pub page: Value,
    pub element: Value,
    pub selector: Value,
}

#[async_trait]
impl Invoke for FnCallPageFindElement {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let page_ident = self.page.unwrap_as_identifier()?;
        let element_ident = self.element.unwrap_as_identifier()?;
        let page = page_ident.unwrap_pointer::<Page>(interpreter)?;
        let selector = self
            .selector
            .as_string()
            .ok_or_else(|| Error::FunctionInvalidArgument("Pemilah harus berupa string"))?;

        let element = page.find_element(selector.0.to_owned()).await.ok();
        match element {
            Some(it) => {
                interpreter.store_variable(element_ident, &element::symbol())?;
                interpreter.store_pointer(element_ident.0.clone(), Box::new(it));
            }
            None => {
                interpreter.store_variable(element_ident, &Value::Null)?;
            }
        }

        Ok(())
    }
}
