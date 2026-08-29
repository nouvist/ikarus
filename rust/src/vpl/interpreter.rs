use flutter_rust_bridge::frb;
use std::{any::Any, collections::HashMap, sync::Arc};
use tokio::task::yield_now;

use crate::{
    shared::{
        abort_controller::AbortController,
        error::Error,
        error_helper::{MapError, OkOrError},
        logger::log,
    },
    vpl::{
        evaluator::Evaluator,
        functions::Invoke,
        tokens::{Identifier, Scope, Value, ValueBoolean},
    },
};

use super::{functions::FnCall, tokens::Statement};

#[frb(ignore)]
type InterpreterPointer = Arc<dyn Any + Send + Sync>;

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
        if !value.is_object() {
            self.remove_pointer(&ident.0);
        }
        self.evaluator.store(ident, value)
    }

    #[inline]
    #[frb(ignore)]
    pub fn get_variable(&mut self, ident: &str) -> Result<Value, Error> {
        self.evaluator
            .evaluate(&Value::Identifier(Identifier(ident.to_owned())))
    }

    #[inline]
    #[frb(ignore)]
    pub fn get_pointer(&mut self, str: &str) -> Option<&InterpreterPointer> {
        self.pointer.get(str)
    }

    #[inline]
    #[frb(ignore)]
    pub fn remove_pointer(&mut self, str: &str) {
        self.pointer.remove_entry(str);
    }

    #[inline]
    #[frb(ignore)]
    pub fn store_pointer(&mut self, str: String, pointer: InterpreterPointer) {
        self.pointer.insert(str, pointer);
    }

    pub fn unwrap_pointer<T: 'static + Send + Sync>(
        &mut self,
        pointer: &Identifier,
    ) -> Result<Arc<T>, Error> {
        let pointer = self
            .get_pointer(&pointer.0)
            .ok_or_function_invalid_argument(
                "Variabel yang dirujuk bukan jenis yang diharapkan".to_owned(),
            )?;
        let pointer = pointer
            .clone()
            .downcast::<T>()
            .map_function_invalid_argument(
                "Variabel yang dirujuk bukan jenis yang diharapkan".to_owned(),
            )?;

        Ok(pointer)
    }

    pub async fn frb_override_run(&mut self, scope: Scope, abort: AbortController) {
        self.pointer.clear();
        self.evaluator.clear();
        let result = abort.run_until_cancelled(self.run(scope)).await;

        let Some(result) = result else {
            log(&format!("[Sistem] Program dihentikan.")).await;
            return ();
        };

        if let Err(err) = result {
            log(&format!("[Sistem] Galat: {err}.")).await;
        }
    }

    pub async fn run(&mut self, scope: Scope) -> Result<(), Error> {
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

                    Box::pin(self.run(it.scope.clone())).await?;
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

                    Box::pin(self.run(it.scope.clone())).await?;
                },
            }
        }

        Ok(())
    }
}
