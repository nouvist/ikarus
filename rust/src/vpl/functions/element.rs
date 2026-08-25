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

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallElementGetOuterHtml {
    pub element: Value,
    pub result: Value,
}

#[async_trait]
impl Invoke for FnCallElementGetOuterHtml {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let element = self
            .element
            .unwrap_as_identifier("Elemen tidak merujuk pada variabel yang valid")?;
        let element = interpreter.unwrap_pointer::<Element>(element)?;
        let html = self
            .result
            .unwrap_as_identifier("Html tidak merujuk pada variabel yang valid")?;
        let str = element.outer_html().await?;

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
    pub result: Value,
}

#[async_trait]
impl Invoke for FnCallElementGetInnerHtml {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let element = self
            .element
            .unwrap_as_identifier("Elemen tidak merujuk pada variabel yang valid")?;
        let element = interpreter.unwrap_pointer::<Element>(element)?;
        let result = self
            .result
            .unwrap_as_identifier("Hasil tidak merujuk pada variabel yang valid")?;
        let content = element.inner_html().await?;

        interpreter.store_variable(
            result,
            &match content {
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
    pub result: Value,
}

#[async_trait]
impl Invoke for FnCallElementGetText {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let element = self
            .element
            .unwrap_as_identifier("Elemen tidak merujuk pada variabel yang valid")?;
        let element = interpreter.unwrap_pointer::<Element>(element)?;
        let result = self
            .result
            .unwrap_as_identifier("Hasil tidak merujuk pada variabel yang valid")?;
        let str = element.inner_text().await?;

        interpreter.store_variable(
            result,
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
        let element = self
            .element
            .unwrap_as_identifier("Elemen tidak merujuk pada variabel yang valid")?;
        let element = interpreter.unwrap_pointer::<Element>(element)?;
        let text = interpreter.evaluate_variable(&self.text)?;
        let text = text.unwrap_as_string("Teks")?;

        element.type_str(&text.0).await?;
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
        let pointer = self.element.unwrap_as_identifier("Elemen")?;
        let pointer = interpreter.unwrap_pointer::<Element>(pointer)?;
        pointer.click().await?;
        Ok(())
    }
}
