use std::time::Duration;

use anyhow::anyhow;
use async_trait::async_trait;
use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};
use tokio::time::sleep;

use crate::{
    log,
    vpl::{functions::Invoke, interpreter::Interpreter, tokens::Value},
};

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallSystemPrint {
    pub content: Value,
}

#[async_trait]
impl Invoke for FnCallSystemPrint {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), anyhow::Error> {
        let evaluated = interpreter.evaluate_variable(&self.content)?;
        let display = match evaluated {
            Value::Null => "null".to_string(),
            Value::String(it) => it.0.clone(),
            Value::Number(it) => it.0.to_string(),
            Value::Boolean(it) => match it.0 {
                true => "Benar".to_string(),
                false => "Salah".to_string(),
            },
            Value::Object(_it) => "[Objek]".to_string(),
            _ => unreachable!(),
        };

        log(display).await;
        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallSystemSleep {
    pub ms: Value,
}

#[async_trait]
impl Invoke for FnCallSystemSleep {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), anyhow::Error> {
        let ms = interpreter.evaluate_variable(&self.ms)?;
        let Value::Number(ms) = ms else {
            return Err(anyhow!("ms harus berupa angka"));
        };

        let ms = ms.0 as u64;
        let ms = Duration::from_millis(ms);
        sleep(ms).await;

        Ok(())
    }
}
