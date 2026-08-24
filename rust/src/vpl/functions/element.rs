use async_trait::async_trait;
use chromiumoxide::Element;
use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::{
    error::Error,
    error_helper::OkOrError,
    vpl::{
        extensions::ValueUnwrapAsIdentifier,
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
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallElementGetOuterHtml {
    pub element: Value,
    pub html: Value,
}

#[async_trait]
impl Invoke for FnCallElementGetOuterHtml {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let pointer = self.element.unwrap_as_identifier()?;
        let pointer = interpreter.unwrap_pointer::<Element>(pointer)?;
        let html = self.html.unwrap_as_identifier()?;
        let str = pointer.outer_html().await?;

        interpreter.store_variable(
            html,
            &match str {
                Some(it) => Value::String(ValueString(it)),
                None => Value::Null,
            },
        )?;
        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallElementGetInnerHtml {
    pub element: Value,
    pub html: Value,
}

#[async_trait]
impl Invoke for FnCallElementGetInnerHtml {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let pointer = self.element.unwrap_as_identifier()?;
        let pointer = interpreter.unwrap_pointer::<Element>(pointer)?;
        let html = self.html.unwrap_as_identifier()?;
        let str = pointer.inner_html().await?;

        interpreter.store_variable(
            html,
            &match str {
                Some(it) => Value::String(ValueString(it)),
                None => Value::Null,
            },
        )?;
        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallElementGetText {
    pub element: Value,
    pub text: Value,
}

#[async_trait]
impl Invoke for FnCallElementGetText {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let pointer = self.element.unwrap_as_identifier()?;
        let pointer = interpreter.unwrap_pointer::<Element>(pointer)?;
        let html = self.text.unwrap_as_identifier()?;
        let str = pointer.inner_text().await?;

        interpreter.store_variable(
            html,
            &match str {
                Some(it) => Value::String(ValueString(it)),
                None => Value::Null,
            },
        )?;
        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallElementType {
    pub element: Value,
    pub text: Value,
}

#[async_trait]
impl Invoke for FnCallElementType {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let pointer = self.element.unwrap_as_identifier()?;
        let pointer = interpreter.unwrap_pointer::<Element>(pointer)?;
        let text = interpreter.evaluate_variable(&self.text)?;
        let text = text
            .as_string()
            .ok_or_function_invalid_argument("Teks haruslah berupa string")?;

        pointer.type_str(&text.0).await?;
        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallElementClick {
    pub element: Value,
}

#[async_trait]
impl Invoke for FnCallElementClick {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let pointer = self.element.unwrap_as_identifier()?;
        let pointer = interpreter.unwrap_pointer::<Element>(pointer)?;
        pointer.click().await?;
        Ok(())
    }
}
