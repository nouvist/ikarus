use async_trait::async_trait;
use chromiumoxide::Element;
use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::{
    shared::error::Error,
    vpl::{
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

#[frb(non_opaque)]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallElementGetOuterHtml {
    pub element: Value,
    pub result: Value,
}

#[async_trait]
impl Invoke for FnCallElementGetOuterHtml {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let element_ptr = self.element.unwrap_as_identifier("Elemen")?;
        let element = interpreter.unwrap_pointer::<Element>(element_ptr)?;
        let result_ptr = self.result.unwrap_as_identifier("Html")?;
        let result = element.outer_html().await?;

        interpreter.store_variable(
            result_ptr,
            &match result {
                Some(it) => Value::String(ValueString(it)),
                None => Value::Null,
            },
        )?;
        Ok(())
    }
}

#[frb(non_opaque)]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallElementGetInnerHtml {
    pub element: Value,
    pub result: Value,
}

#[async_trait]
impl Invoke for FnCallElementGetInnerHtml {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let element_ptr = self.element.unwrap_as_identifier("Elemen")?;
        let element = interpreter.unwrap_pointer::<Element>(element_ptr)?;
        let result_ptr = self.result.unwrap_as_identifier("Hasil")?;
        let result = element.inner_html().await?;

        interpreter.store_variable(
            result_ptr,
            &match result {
                Some(it) => Value::String(ValueString(it)),
                None => Value::Null,
            },
        )?;
        Ok(())
    }
}

#[frb(non_opaque)]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallElementGetText {
    pub element: Value,
    pub result: Value,
}

#[async_trait]
impl Invoke for FnCallElementGetText {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let element_ptr = self.element.unwrap_as_identifier("Elemen")?;
        let element = interpreter.unwrap_pointer::<Element>(element_ptr)?;
        let result_ptr = self.result.unwrap_as_identifier("Hasil")?;
        let result = element.inner_text().await?;

        interpreter.store_variable(
            result_ptr,
            &match result {
                Some(it) => Value::String(ValueString(it)),
                None => Value::Null,
            },
        )?;
        Ok(())
    }
}

#[frb(non_opaque)]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallElementType {
    pub element: Value,
    pub text: Value,
}

#[async_trait]
impl Invoke for FnCallElementType {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let element_ptr = self.element.unwrap_as_identifier("Elemen")?;
        let element = interpreter.unwrap_pointer::<Element>(element_ptr)?;
        let text = interpreter.evaluate_variable(&self.text)?;
        let text = text.unwrap_as_string("Teks")?;
        element.focus().await?;
        element.type_str(&text.0).await?;
        Ok(())
    }
}

#[frb(non_opaque)]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallElementClick {
    pub element: Value,
}

#[async_trait]
impl Invoke for FnCallElementClick {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let element_ptr = self.element.unwrap_as_identifier("Elemen")?;
        let element = interpreter.unwrap_pointer::<Element>(element_ptr)?;
        element.focus().await?;
        element.click().await?;
        Ok(())
    }
}
