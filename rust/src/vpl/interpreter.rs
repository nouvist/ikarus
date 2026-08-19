use flutter_rust_bridge::frb;

use crate::vpl::{
    evaluator::Evaluator,
    tokens::{Scope, VarBoolean, Variable},
};

use super::tokens::{Statement, VarComputedOperation};

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

    pub fn run(&mut self, scope: Scope) -> Result<(), anyhow::Error> {
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

                    self.run(it.scope.clone())?;
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

                    self.run(it.scope.clone())?;
                }
                Statement::Variable(it) => {
                    self.evaluator.save(it.ident.clone(), it.value.clone())?;
                },
                Statement::Call(it) => todo!(),
            }
        }

        Ok(())
    }
}
