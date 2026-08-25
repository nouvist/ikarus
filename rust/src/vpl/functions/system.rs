use std::time::Duration;

use async_trait::async_trait;
use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};
use tokio::time::sleep;

use crate::{
    shared::{error::Error, logger::log},
    vpl::{functions::Invoke, interpreter::Interpreter, tokens::Value},
};

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallSystemPrint {
    pub content: Value,
}

#[async_trait]
impl Invoke for FnCallSystemPrint {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let evaluated = interpreter.evaluate_variable(&self.content)?;
        log(evaluated.display()).await;
        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallSystemSleep {
    pub ms: Value,
}

#[async_trait]
impl Invoke for FnCallSystemSleep {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let ms = interpreter.evaluate_variable(&self.ms)?;
        let ms = ms.unwrap_as_number("Milidetik")?;

        let ms = ms.0 as u64;
        let ms = Duration::from_millis(ms);
        sleep(ms).await;

        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallSystemStop {}

#[async_trait]
impl Invoke for FnCallSystemStop {
    async fn invoke(&self, _interpreter: &mut Interpreter) -> Result<(), Error> {
        // dummy, diimplement di interpreter
        Ok(())
    }
}
