use async_trait::async_trait;
use chromiumoxide::Element;
use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::{
    error::Error,
    vpl::{
        extensions::{IdentifierUnwrapPointer, ValueUnwrapAsIdentifier},
        functions::Invoke,
        interpreter::Interpreter,
        tokens::{Value, ValueObject, ValueString},
    },
};

pub fn symbol() -> Value {
    Value::Object(ValueObject {
        symbol: "[Objek Elemen]".to_owned(),
    })
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallElementGetOuterHtml {
    pub element: Value,
    pub html: Value,
}

#[async_trait]
impl Invoke for FnCallElementGetOuterHtml {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let ident_element = self.element.unwrap_as_identifier()?;
        let ident_html = self.html.unwrap_as_identifier()?;
        let pointer = ident_element.unwrap_pointer::<Element>(interpreter)?;
        let html = pointer.outer_html().await?;

        interpreter.store_variable(
            ident_html,
            &match html {
                Some(it) => Value::String(ValueString(it)),
                None => Value::Null,
            },
        )?;

        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallElementGetInnerHtml {
    pub element: Value,
    pub html: Value,
}

#[async_trait]
impl Invoke for FnCallElementGetInnerHtml {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let ident_element = self.element.unwrap_as_identifier()?;
        let ident_html = self.html.unwrap_as_identifier()?;
        let pointer = ident_element.unwrap_pointer::<Element>(interpreter)?;
        let html = pointer.inner_html().await?;

        interpreter.store_variable(
            ident_html,
            &match html {
                Some(it) => Value::String(ValueString(it)),
                None => Value::Null,
            },
        )?;

        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallElementGetText {
    pub element: Value,
    pub text: Value,
}

#[async_trait]
impl Invoke for FnCallElementGetText {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let ident_element = self.element.unwrap_as_identifier()?;
        let ident_html = self.text.unwrap_as_identifier()?;
        let pointer = ident_element.unwrap_pointer::<Element>(interpreter)?;
        let html = pointer.inner_text().await?;

        interpreter.store_variable(
            ident_html,
            &match html {
                Some(it) => Value::String(ValueString(it)),
                None => Value::Null,
            },
        )?;

        Ok(())
    }
}
