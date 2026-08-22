use async_trait::async_trait;
use chromiumoxide::Page;
use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::{
    error::Error,
    vpl::{
        extensions::{IdentifierUnwrapPointer, ValueUnwrapAsIdentifier},
        functions::Invoke,
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
