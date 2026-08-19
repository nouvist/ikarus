use async_trait::async_trait;
use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::{
    log,
    vpl::{functions::Invoke, interpreter::Interpreter, tokens::Variable},
};

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallConsolePrint {
    pub content: Variable,
}

#[async_trait]
impl Invoke for FnCallConsolePrint {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), anyhow::Error> {
        let evaluated = interpreter.evaluator().evaluate(self.content.clone())?;
        let display = match evaluated {
            Variable::Null => "null".to_string(),
            Variable::String(it) => it.0.clone(),
            Variable::Number(it) => it.0.to_string(),
            Variable::Boolean(it) => match it.0 {
                true => "Benar".to_string(),
                false => "Salah".to_string(),
            },
            Variable::Object(_it) => "[Objek]".to_string(),
            _ => unreachable!(),
        };

        log(display).await;
        Ok(())
    }
}
