use flutter_rust_bridge::frb;
use tokio::task::yield_now;

use crate::{
    log,
    vpl::{
        evaluator::Evaluator,
        functions::Invoke,
        tokens::{Scope, ValueBoolean, Value},
    },
};

use super::tokens::Statement;

#[frb(opaque)]
pub struct Interpreter {
    evaluator: Evaluator,
}

impl Interpreter {
    #[frb(sync)]
    pub fn new() -> Self {
        Self {
            evaluator: Evaluator::new(),
        }
    }

    #[frb(sync)]
    pub fn evaluator(&mut self) -> &mut Evaluator {
        &mut self.evaluator
    }

    pub async fn run(&mut self, scope: Scope) {
        log("[Sistem] Menjalankan algoritma...").await;
        let result = self.run_unsafe(scope).await;
        match result {
            Ok(_) => log("[Sistem] Selesai.").await,
            Err(it) => log(&format!("[Sistem] Galat: {it}")).await,
        }
    }

    pub async fn run_unsafe(&mut self, scope: Scope) -> Result<(), anyhow::Error> {
        for st in &scope.0 {
            match st {
                Statement::If(it) => {
                    let condition = self.evaluator.evaluate(it.condition.clone())?;
                    let Value::Boolean(condition) = condition else {
                        continue;
                    };

                    let ValueBoolean(condition) = condition;
                    if !condition {
                        continue;
                    }

                    Box::pin(self.run_unsafe(it.scope.clone())).await?;
                }
                Statement::For(it) => loop {
                    let condition = self.evaluator.evaluate(it.condition.clone())?;
                    let Value::Boolean(condition) = condition else {
                        continue;
                    };

                    let ValueBoolean(condition) = condition;
                    if !condition {
                        continue;
                    }

                    Box::pin(self.run_unsafe(it.scope.clone())).await?;
                },
                Statement::Variable(it) => {
                    self.evaluator.save(it.ident.clone(), it.value.clone())?;
                }
                Statement::Call(it) => it.0.invoke(self).await?,
            }

            yield_now().await;
        }

        Ok(())
    }
}
