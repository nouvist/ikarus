use async_trait::async_trait;
use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::{
    log,
    vpl::{functions::Invoke, interpreter::Interpreter, tokens::Value},
};

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallConsolePrint {
    pub content: Value,
}

#[async_trait]
impl Invoke for FnCallConsolePrint {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), anyhow::Error> {
        let evaluated = interpreter.evaluator().evaluate(self.content.clone())?;
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
