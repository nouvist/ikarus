use std::collections::HashMap;

use flutter_rust_bridge::frb;

use crate::{
    error::Error,
    error_helper::OkOrError,
    vpl::tokens::{
        Identifier, Value, ValueBoolean, ValueComputedOperation, ValueNumber, ValueString,
    },
};

#[frb(ignore)]
pub struct Evaluator {
    pub jar: HashMap<String, Value>,
}

#[frb(ignore)]
impl Evaluator {
    pub fn new() -> Self {
        Self {
            jar: HashMap::with_capacity(256),
        }
    }

    pub fn evaluate(&mut self, var: &Value) -> Result<Value, Error> {
        match var {
            Value::Identifier(ident) => {
                let resolved = self
                    .jar
                    .get(&ident.0)
                    .cloned()
                    .ok_or_evaluator_no_variable()?;
                Ok(resolved)
            }
            Value::Computed(it) => {
                let left = self.evaluate(&it.left)?;
                let right = self.evaluate(&it.right)?;

                Evaluator::apply(&it.operation, &left, &right).ok_or_evaluator_invalid_variable()
            }
            it => Ok(it.clone()),
        }
    }

    pub fn store(&mut self, ident: &Identifier, var: &Value) -> Result<Value, Error> {
        let evaluated = self.evaluate(var)?;
        self.jar.insert(ident.0.clone(), evaluated.clone());
        Ok(evaluated)
    }

    pub fn clear(&mut self) {
        self.jar.clear();
    }

    fn apply(operation: &ValueComputedOperation, left: &Value, right: &Value) -> Option<Value> {
        match (operation, left, right) {
            (ValueComputedOperation::Add, left, right) => Self::apply_add(left, right),
            (ValueComputedOperation::Subtract, left, right) => Self::apply_subtract(left, right),
            (ValueComputedOperation::Multiply, left, right) => Self::apply_multiply(left, right),
            (ValueComputedOperation::Divide, left, right) => Self::apply_divide(left, right),
            (ValueComputedOperation::Modulo, left, right) => Self::apply_modulo(left, right),

            (ValueComputedOperation::BoolAnd, left, right) => Self::apply_bool_and(left, right),
            (ValueComputedOperation::BoolOr, left, right) => Self::apply_bool_or(left, right),

            (ValueComputedOperation::BoolEq, left, right) => Self::apply_bool_eq(left, right),
            (ValueComputedOperation::BoolNe, left, right) => Self::apply_bool_ne(left, right),
            (ValueComputedOperation::BoolLt, left, right) => Self::apply_bool_lt(left, right),
            (ValueComputedOperation::BoolLe, left, right) => Self::apply_bool_le(left, right),
            (ValueComputedOperation::BoolGt, left, right) => Self::apply_bool_gt(left, right),
            (ValueComputedOperation::BoolGe, left, right) => Self::apply_bool_ge(left, right),
        }
    }

    fn apply_add(left: &Value, right: &Value) -> Option<Value> {
        match (left, right) {
            (Value::Number(left), Value::Number(right)) => {
                Some(Value::Number(ValueNumber(left.0 + right.0)))
            }
            (Value::String(left), right) => Some(Value::String(ValueString(format!(
                "{}{}",
                left.0,
                right.display()
            )))),
            (left, Value::String(right)) => Some(Value::String(ValueString(format!(
                "{}{}",
                left.display(),
                right.0
            )))),
            _ => None,
        }
    }

    fn apply_subtract(left: &Value, right: &Value) -> Option<Value> {
        match (left, right) {
            (Value::Number(left), Value::Number(right)) => {
                Some(Value::Number(ValueNumber(left.0 - right.0)))
            }
            _ => None,
        }
    }

    fn apply_multiply(left: &Value, right: &Value) -> Option<Value> {
        match (left, right) {
            (Value::Number(left), Value::Number(right)) => {
                Some(Value::Number(ValueNumber(left.0 * right.0)))
            }
            _ => None,
        }
    }

    fn apply_divide(left: &Value, right: &Value) -> Option<Value> {
        match (left, right) {
            (Value::Number(left), Value::Number(right)) => match right.0 != 0.0 {
                true => Some(Value::Number(ValueNumber(left.0 / right.0))),
                false => None,
            },
            _ => None,
        }
    }

    fn apply_modulo(left: &Value, right: &Value) -> Option<Value> {
        match (left, right) {
            (Value::Number(left), Value::Number(right)) => match right.0 != 0.0 {
                true => Some(Value::Number(ValueNumber(left.0 % right.0))),
                false => None,
            },
            _ => None,
        }
    }

    fn apply_bool_and(left: &Value, right: &Value) -> Option<Value> {
        match (left, right) {
            (Value::Boolean(left), Value::Boolean(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 && right.0)))
            }
            (Value::Boolean(left), right) => {
                Some(Value::Boolean(ValueBoolean(left.0 && right.boolean())))
            }
            (left, Value::Boolean(right)) => {
                Some(Value::Boolean(ValueBoolean(left.boolean() && right.0)))
            }
            _ => None,
        }
    }

    fn apply_bool_or(left: &Value, right: &Value) -> Option<Value> {
        match (left, right) {
            (Value::Boolean(left), Value::Boolean(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 || right.0)))
            }
            (Value::Boolean(left), right) => {
                Some(Value::Boolean(ValueBoolean(left.0 || right.boolean())))
            }
            (left, Value::Boolean(right)) => {
                Some(Value::Boolean(ValueBoolean(left.boolean() || right.0)))
            }
            _ => None,
        }
    }

    fn apply_bool_eq(left: &Value, right: &Value) -> Option<Value> {
        Some(Value::Boolean(ValueBoolean(left == right)))
    }

    fn apply_bool_ne(left: &Value, right: &Value) -> Option<Value> {
        Some(Value::Boolean(ValueBoolean(left != right)))
    }

    fn apply_bool_lt(left: &Value, right: &Value) -> Option<Value> {
        match (left, right) {
            (Value::Number(left), Value::Number(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 < right.0)))
            }
            _ => None,
        }
    }

    fn apply_bool_le(left: &Value, right: &Value) -> Option<Value> {
        match (left, right) {
            (Value::Number(left), Value::Number(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 <= right.0)))
            }
            _ => None,
        }
    }

    fn apply_bool_gt(left: &Value, right: &Value) -> Option<Value> {
        match (left, right) {
            (Value::Number(left), Value::Number(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 > right.0)))
            }
            _ => None,
        }
    }

    fn apply_bool_ge(left: &Value, right: &Value) -> Option<Value> {
        match (left, right) {
            (Value::Number(left), Value::Number(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 >= right.0)))
            }
            _ => None,
        }
    }
}
