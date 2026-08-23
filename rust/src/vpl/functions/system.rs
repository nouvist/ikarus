use std::time::Duration;

use async_trait::async_trait;
use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};
use tokio::time::sleep;

use crate::{
    error::Error,
    log,
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
        let display = match evaluated {
            Value::Null => "null".to_string(),
            Value::String(it) => it.0.clone(),
            Value::Number(it) => it.0.to_string(),
            Value::Boolean(it) => match it.0 {
                true => "Benar".to_string(),
                false => "Salah".to_string(),
            },
            Value::Object(it) => it.symbol,
            _ => unreachable!(),
        };

        log(display).await;
        sleep(Duration::from_millis(5)).await;
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
        let ms = ms
            .as_number()
            .ok_or_else(|| Error::FunctionInvalidArgument("Milidetik harus berupa angka"))?;

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
