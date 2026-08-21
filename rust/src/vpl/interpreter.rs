use flutter_rust_bridge::frb;
use std::{sync::Arc, time::Duration};
use tokio::time::sleep;
use tokio_util::sync::CancellationToken;

use crate::{
    impl_copy, log,
    vpl::{
        evaluator::Evaluator,
        functions::Invoke,
        tokens::{Scope, Value, ValueBoolean},
    },
};

use super::tokens::Statement;

#[frb(opaque)]
#[derive(Clone)]
pub struct InterpreterAbortController(Arc<CancellationToken>);

impl InterpreterAbortController {
    #[frb(sync)]
    pub fn new() -> Self {
        Self(Arc::new(CancellationToken::new()))
    }

    #[frb(sync)]
    pub fn abort(&self) {
        self.0.cancel();
    }
}

impl_copy!(InterpreterAbortController);

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

    pub async fn run(&mut self, scope: Scope, abort: InterpreterAbortController) {
        log(&format!("[Sistem] Program dijalankan...")).await;

        self.evaluator.clear();
        let result = abort.0.run_until_cancelled(self.run_unsafe(scope)).await;

        let Some(result) = result else {
            log(&format!("[Sistem] Program dihentikan.")).await;
            return ();
        };

        if let Err(err) = result {
            log(&format!("[Sistem] Galat: {err}")).await;
        } else {
            log(&format!("[Sistem] Program selesai.")).await;
        }
    }

    async fn run_unsafe(&mut self, scope: Scope) -> Result<(), anyhow::Error> {
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
                        break;
                    };

                    let ValueBoolean(condition) = condition;
                    if !condition {
                        break;
                    }

                    Box::pin(self.run_unsafe(it.scope.clone())).await?;
                },
                Statement::Variable(it) => {
                    self.evaluator.save(it.ident.clone(), it.value.clone())?;
                }
                Statement::Call(it) => it.0.invoke(self).await?,
            }

            sleep(Duration::from_millis(5)).await;
        }

        Ok(())
    }
}
