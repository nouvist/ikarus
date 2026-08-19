use flutter_rust_bridge::frb;
use tokio::task::yield_now;

use crate::vpl::{
    evaluator::Evaluator,
    functions::Invoke,
    tokens::{Scope, VarBoolean, Variable},
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

    pub async fn run(&mut self, scope: Scope) -> Result<(), anyhow::Error> {
        for st in &scope.0 {
            match st {
                Statement::If(it) => {
                    let condition = self.evaluator.evaluate(it.condition.clone())?;
                    let Variable::Boolean(condition) = condition else {
                        continue;
                    };

                    let VarBoolean(condition) = condition;
                    if !condition {
                        continue;
                    }

                    Box::pin(self.run(it.scope.clone())).await?;
                }
                Statement::For(it) => {
                    let condition = self.evaluator.evaluate(it.condition.clone())?;
                    let Variable::Boolean(condition) = condition else {
                        continue;
                    };

                    let VarBoolean(condition) = condition;
                    if !condition {
                        continue;
                    }

                    Box::pin(self.run(it.scope.clone())).await?;
                }
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
