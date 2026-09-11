use std::collections::HashMap;

use flutter_rust_bridge::frb;

use crate::{
    shared::{error::Error, error_helper::OkOrError},
    vpl::tokens::{
        Identifier, Val, ValueBoolean, ValueComputedOperation, ValueNumber, ValueString,
    },
};

#[frb(ignore)]
pub struct Evaluator {
    pub jar: HashMap<String, Val>,
}

#[frb(ignore)]
impl Evaluator {
    pub fn new() -> Self {
        Self {
            jar: HashMap::with_capacity(256),
        }
    }

    pub fn evaluate(&mut self, var: &Val) -> Result<Val, Error> {
        match var {
            Val::Identifier(ident) => {
                let resolved = self
                    .jar
                    .get(&ident.0)
                    .cloned()
                    .ok_or_evaluator_no_variable()?;
                Ok(resolved)
            }
            Val::Computed(it) => {
                let left = self.evaluate(&it.left)?;
                let right = self.evaluate(&it.right)?;

                Evaluator::apply(&it.operation, &left, &right).ok_or_evaluator_invalid_variable()
            }
            it => Ok(it.clone()),
        }
    }

    pub fn store(&mut self, ident: &Identifier, var: &Val) -> Result<Val, Error> {
        let evaluated = self.evaluate(var)?;
        self.jar.insert(ident.0.clone(), evaluated.clone());
        Ok(evaluated)
    }

    pub fn remove(&mut self, ident: &str) {
        self.jar.remove(ident);
    }

    pub fn clear(&mut self) {
        self.jar.clear();
    }

    fn apply(operation: &ValueComputedOperation, left: &Val, right: &Val) -> Option<Val> {
        match (operation, left, right) {
            (ValueComputedOperation::Add, left, right) => Self::apply_add(left, right),
            (ValueComputedOperation::Subtract, left, right) => Self::apply_subtract(left, right),
            (ValueComputedOperation::Multiply, left, right) => Self::apply_multiply(left, right),
            (ValueComputedOperation::Divide, left, right) => Self::apply_divide(left, right),
            (ValueComputedOperation::Modulo, left, right) => Self::apply_modulo(left, right),

            (ValueComputedOperation::BoolAnd, left, right) => Self::apply_bool_and(left, right),
            (ValueComputedOperation::BoolOr, left, right) => Self::apply_bool_or(left, right),

            (ValueComputedOperation::BoolEqual, left, right) => Self::apply_bool_eq(left, right),
            (ValueComputedOperation::BoolNotEqual, left, right) => Self::apply_bool_ne(left, right),
            (ValueComputedOperation::BoolLessThan, left, right) => Self::apply_bool_lt(left, right),
            (ValueComputedOperation::BoolLessThanOrEqual, left, right) => Self::apply_bool_le(left, right),
            (ValueComputedOperation::BoolGreaterThan, left, right) => Self::apply_bool_gt(left, right),
            (ValueComputedOperation::BoolGreatherThanOrEqual, left, right) => Self::apply_bool_ge(left, right),
        }
    }

    fn apply_add(left: &Val, right: &Val) -> Option<Val> {
        match (left, right) {
            (Val::Number(left), Val::Number(right)) => {
                Some(Val::Number(ValueNumber(left.0 + right.0)))
            }
            (Val::String(left), right) => Some(Val::String(ValueString(format!(
                "{}{}",
                left.0,
                right.display()
            )))),
            (left, Val::String(right)) => Some(Val::String(ValueString(format!(
                "{}{}",
                left.display(),
                right.0
            )))),
            _ => None,
        }
    }

    fn apply_subtract(left: &Val, right: &Val) -> Option<Val> {
        match (left, right) {
            (Val::Number(left), Val::Number(right)) => {
                Some(Val::Number(ValueNumber(left.0 - right.0)))
            }
            _ => None,
        }
    }

    fn apply_multiply(left: &Val, right: &Val) -> Option<Val> {
        match (left, right) {
            (Val::Number(left), Val::Number(right)) => {
                Some(Val::Number(ValueNumber(left.0 * right.0)))
            }
            _ => None,
        }
    }

    fn apply_divide(left: &Val, right: &Val) -> Option<Val> {
        match (left, right) {
            (Val::Number(left), Val::Number(right)) => match right.0 != 0.0 {
                true => Some(Val::Number(ValueNumber(left.0 / right.0))),
                false => None,
            },
            _ => None,
        }
    }

    fn apply_modulo(left: &Val, right: &Val) -> Option<Val> {
        match (left, right) {
            (Val::Number(left), Val::Number(right)) => match right.0 != 0.0 {
                true => Some(Val::Number(ValueNumber(left.0 % right.0))),
                false => None,
            },
            _ => None,
        }
    }

    fn apply_bool_and(left: &Val, right: &Val) -> Option<Val> {
        match (left, right) {
            (Val::Boolean(left), Val::Boolean(right)) => {
                Some(Val::Boolean(ValueBoolean(left.0 && right.0)))
            }
            (Val::Boolean(left), right) => {
                Some(Val::Boolean(ValueBoolean(left.0 && right.boolean())))
            }
            (left, Val::Boolean(right)) => {
                Some(Val::Boolean(ValueBoolean(left.boolean() && right.0)))
            }
            _ => None,
        }
    }

    fn apply_bool_or(left: &Val, right: &Val) -> Option<Val> {
        match (left, right) {
            (Val::Boolean(left), Val::Boolean(right)) => {
                Some(Val::Boolean(ValueBoolean(left.0 || right.0)))
            }
            (Val::Boolean(left), right) => {
                Some(Val::Boolean(ValueBoolean(left.0 || right.boolean())))
            }
            (left, Val::Boolean(right)) => {
                Some(Val::Boolean(ValueBoolean(left.boolean() || right.0)))
            }
            _ => None,
        }
    }

    fn apply_bool_eq(left: &Val, right: &Val) -> Option<Val> {
        match (left, right) {
            (Val::Object(_), Val::Object(_)) => Some(Val::Boolean(ValueBoolean(false))),
            (Val::Object(_), _) => Some(Val::Boolean(ValueBoolean(false))),
            (_, Val::Object(_)) => Some(Val::Boolean(ValueBoolean(false))),
            (left, right) => Some(Val::Boolean(ValueBoolean(left == right))),
        }
    }

    fn apply_bool_ne(left: &Val, right: &Val) -> Option<Val> {
        match (left, right) {
            (Val::Object(_), Val::Object(_)) => Some(Val::Boolean(ValueBoolean(true))),
            (Val::Object(_), _) => Some(Val::Boolean(ValueBoolean(true))),
            (_, Val::Object(_)) => Some(Val::Boolean(ValueBoolean(true))),
            (left, right) => Some(Val::Boolean(ValueBoolean(left != right))),
        }
    }

    fn apply_bool_lt(left: &Val, right: &Val) -> Option<Val> {
        match (left, right) {
            (Val::Number(left), Val::Number(right)) => {
                Some(Val::Boolean(ValueBoolean(left.0 < right.0)))
            }
            _ => None,
        }
    }

    fn apply_bool_le(left: &Val, right: &Val) -> Option<Val> {
        match (left, right) {
            (Val::Number(left), Val::Number(right)) => {
                Some(Val::Boolean(ValueBoolean(left.0 <= right.0)))
            }
            _ => None,
        }
    }

    fn apply_bool_gt(left: &Val, right: &Val) -> Option<Val> {
        match (left, right) {
            (Val::Number(left), Val::Number(right)) => {
                Some(Val::Boolean(ValueBoolean(left.0 > right.0)))
            }
            _ => None,
        }
    }

    fn apply_bool_ge(left: &Val, right: &Val) -> Option<Val> {
        match (left, right) {
            (Val::Number(left), Val::Number(right)) => {
                Some(Val::Boolean(ValueBoolean(left.0 >= right.0)))
            }
            _ => None,
        }
    }
}
