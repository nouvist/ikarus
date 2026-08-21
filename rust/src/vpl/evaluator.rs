use std::collections::HashMap;

use flutter_rust_bridge::frb;

use crate::{
    error::Error,
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
                    .ok_or_else(|| Error::EvaluatorNoVariable)?;
                Ok(resolved)
            }
            Value::Computed(it) => {
                let left = self.evaluate(&it.left)?;
                let right = self.evaluate(&it.right)?;

                Evaluator::apply(&it.operation, &left, &right)
                    .ok_or_else(|| Error::EvaluatorInvalidVariable)
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
            // Add
            (ValueComputedOperation::Add, Value::Number(left), Value::Number(right)) => {
                Some(Value::Number(ValueNumber(left.0 + right.0)))
            }
            (ValueComputedOperation::Add, Value::String(left), Value::String(right)) => {
                Some(Value::String(ValueString(format!("{}{}", left.0, right.0))))
            }
            (ValueComputedOperation::Add, Value::String(left), Value::Number(right)) => {
                Some(Value::String(ValueString(format!("{}{}", left.0, right.0))))
            }
            (ValueComputedOperation::Add, Value::Number(left), Value::String(right)) => {
                Some(Value::String(ValueString(format!("{}{}", left.0, right.0))))
            }

            // Subtract
            (ValueComputedOperation::Subtract, Value::Number(left), Value::Number(right)) => {
                Some(Value::Number(ValueNumber(left.0 - right.0)))
            }

            // Multiply
            (ValueComputedOperation::Multiply, Value::Number(left), Value::Number(right)) => {
                Some(Value::Number(ValueNumber(left.0 * right.0)))
            }

            // Divide
            (ValueComputedOperation::Divide, Value::Number(left), Value::Number(right)) => {
                if right.0 == 0.0 {
                    None
                } else {
                    Some(Value::Number(ValueNumber(left.0 / right.0)))
                }
            }

            // Reminder
            (ValueComputedOperation::Reminder, Value::Number(left), Value::Number(right)) => {
                if right.0 == 0.0 {
                    None
                } else {
                    Some(Value::Number(ValueNumber(left.0 % right.0)))
                }
            }

            // BoolAnd
            (ValueComputedOperation::BoolAnd, Value::Number(left), Value::Boolean(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 != 0.0 && right.0)))
            }
            (ValueComputedOperation::BoolAnd, Value::Boolean(left), Value::Number(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 && right.0 != 0.0)))
            }
            (ValueComputedOperation::BoolAnd, Value::Number(left), Value::Number(right)) => Some(
                Value::Boolean(ValueBoolean(left.0 != 0.0 && right.0 != 0.0)),
            ),
            (ValueComputedOperation::BoolAnd, Value::Boolean(left), Value::Boolean(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 && right.0)))
            }

            // BoolOr
            (ValueComputedOperation::BoolOr, Value::Number(left), Value::Boolean(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 != 0.0 || right.0)))
            }
            (ValueComputedOperation::BoolOr, Value::Boolean(left), Value::Number(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 || right.0 != 0.0)))
            }
            (ValueComputedOperation::BoolOr, Value::Number(left), Value::Number(right)) => Some(
                Value::Boolean(ValueBoolean(left.0 != 0.0 || right.0 != 0.0)),
            ),
            (ValueComputedOperation::BoolOr, Value::Boolean(left), Value::Boolean(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 || right.0)))
            }

            // BoolEq
            (ValueComputedOperation::BoolEq, Value::Boolean(left), Value::Boolean(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 == right.0)))
            }
            (ValueComputedOperation::BoolEq, Value::Number(left), Value::Number(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 == right.0)))
            }
            (ValueComputedOperation::BoolEq, Value::String(left), Value::String(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 == right.0)))
            }

            // BoolLt
            (ValueComputedOperation::BoolLt, Value::Boolean(left), Value::Boolean(right)) => {
                Some(Value::Boolean(ValueBoolean(!left.0 && right.0)))
            }
            (ValueComputedOperation::BoolLt, Value::Number(left), Value::Number(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 < right.0)))
            }
            (ValueComputedOperation::BoolLt, Value::String(left), Value::String(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 < right.0)))
            }

            // BoolLe
            (ValueComputedOperation::BoolLe, Value::Boolean(left), Value::Boolean(right)) => {
                Some(Value::Boolean(ValueBoolean(!left.0 || right.0)))
            }
            (ValueComputedOperation::BoolLe, Value::Number(left), Value::Number(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 <= right.0)))
            }
            (ValueComputedOperation::BoolLe, Value::String(left), Value::String(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 <= right.0)))
            }

            // BoolGt
            (ValueComputedOperation::BoolGt, Value::Boolean(left), Value::Boolean(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 && !right.0)))
            }
            (ValueComputedOperation::BoolGt, Value::Number(left), Value::Number(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 > right.0)))
            }
            (ValueComputedOperation::BoolGt, Value::String(left), Value::String(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 > right.0)))
            }

            // BoolGe
            (ValueComputedOperation::BoolGe, Value::Boolean(left), Value::Boolean(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 || !right.0)))
            }
            (ValueComputedOperation::BoolGe, Value::Number(left), Value::Number(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 >= right.0)))
            }
            (ValueComputedOperation::BoolGe, Value::String(left), Value::String(right)) => {
                Some(Value::Boolean(ValueBoolean(left.0 >= right.0)))
            }

            _ => None,
        }
    }
}
