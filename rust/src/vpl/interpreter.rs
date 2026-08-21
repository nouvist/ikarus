use flutter_rust_bridge::frb;
use std::{any::Any, collections::HashMap, sync::Arc};
use tokio::task::yield_now;
use tokio_util::sync::CancellationToken;

use crate::{
    error::Error,
    impl_copy, log,
    vpl::{
        evaluator::Evaluator,
        functions::Invoke,
        tokens::{Identifier, Scope, Value, ValueBoolean},
    },
};

use super::{functions::FnCall, tokens::Statement};

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

#[frb(ignore)]
type InterpreterPointer = Box<dyn Any + Send + Sync>;

#[frb(opaque)]
pub struct Interpreter {
    evaluator: Evaluator,
    pointer: HashMap<String, InterpreterPointer>,
}

impl Interpreter {
    #[frb(sync)]
    pub fn new() -> Self {
        Self {
            evaluator: Evaluator::new(),
            pointer: HashMap::with_capacity(256),
        }
    }

    #[inline]
    #[frb(sync)]
    pub fn evaluate_variable(&mut self, value: &Value) -> Result<Value, Error> {
        self.evaluator.evaluate(value)
    }

    #[inline]
    #[frb(sync)]
    pub fn store_variable(&mut self, ident: &Identifier, value: &Value) -> Result<Value, Error> {
        self.evaluator.store(ident, value)
    }

    #[inline]
    #[frb(ignore)]
    pub fn get_pointer(&mut self, str: &str) -> Option<&InterpreterPointer> {
        self.pointer.get(str)
    }

    #[inline]
    #[frb(ignore)]
    pub fn store_pointer(&mut self, str: String, pointer: InterpreterPointer) {
        self.pointer.insert(str, pointer);
    }

    pub async fn run(&mut self, scope: Scope, abort: InterpreterAbortController) {
        self.pointer.clear();
        self.evaluator.clear();
        let result = abort.0.run_until_cancelled(self.run_unsafe(scope)).await;

        let Some(result) = result else {
            log(&format!("[Sistem] Program dihentikan.")).await;
            return ();
        };

        if let Err(err) = result {
            log(&format!("[Sistem] Galat: {err}.")).await;
        }
    }

    async fn run_unsafe(&mut self, scope: Scope) -> Result<(), Error> {
        for st in &scope.0 {
            yield_now().await;
            match st {
                Statement::Call(it) => {
                    match &it.0 {
                        FnCall::SystemStop(_) => return Ok(()),
                        it => it.invoke(self).await,
                    }?;
                }
                Statement::Variable(it) => {
                    self.store_variable(&it.ident, &it.value)?;
                }
                Statement::If(it) => {
                    let condition = self.evaluate_variable(&it.condition)?;
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
                    let condition = self.evaluate_variable(&it.condition)?;
                    let Value::Boolean(condition) = condition else {
                        break;
                    };

                    let ValueBoolean(condition) = condition;
                    if !condition {
                        break;
                    }

                    Box::pin(self.run_unsafe(it.scope.clone())).await?;
                },
            }
        }

        Ok(())
    }
}
