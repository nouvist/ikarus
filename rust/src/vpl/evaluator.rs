use std::collections::HashMap;

use anyhow::anyhow;
use flutter_rust_bridge::frb;

use crate::vpl::tokens::{Identifier, ValueBoolean, ValueComputedOperation, ValueNumber, ValueString, Value};

#[frb(opaque)]
pub struct Evaluator {
    pub jar: HashMap<String, Value>,
}

impl Evaluator {
    #[frb(sync)]
    pub fn new() -> Self {
        Self {
            jar: HashMap::with_capacity(256),
        }
    }

    #[inline]
    #[frb(sync)]
    pub fn clear(&mut self) {
        self.jar.clear();
    }

    #[frb(sync)]
    pub fn evaluate(&mut self, var: Value) -> Result<Value, anyhow::Error> {
        match var {
            Value::Ident(ident) => {
                let resolved = self
                    .jar
                    .get(&ident.0)
                    .cloned()
                    .ok_or_else(|| anyhow!("variabel yang dirujuk tidak ditemukan"))?;
                Ok(resolved)
            }
            Value::Computed(it) => {
                let left = self.evaluate(*it.left)?;
                let right = self.evaluate(*it.right)?;

                Evaluator::apply(&it.operation, &left, &right)
                    .ok_or_else(|| anyhow!("variabel tidak valid untuk dievaluasi"))
            }
            it => Ok(it.clone()),
        }
    }

    #[frb(sync)]
    pub fn save(&mut self, ident: Identifier, var: Value) -> Result<Value, anyhow::Error> {
        let evaluated = self.evaluate(var)?;
        self.jar.insert(ident.0, evaluated.clone());
        Ok(evaluated)
    }

    #[frb(sync)]
    fn apply(
        operation: &ValueComputedOperation,
        left: &Value,
        right: &Value,
    ) -> Option<Value> {
        match (operation, left, right) {
            // Add
            (ValueComputedOperation::Add, Value::Number(left), Value::Number(right)) => {
                Some(Value::Number(ValueNumber(left.0 + right.0)))
            }
            (ValueComputedOperation::Add, Value::String(left), Value::String(right)) => Some(
                Value::String(ValueString(format!("{}{}", left.0, right.0))),
            ),
            (ValueComputedOperation::Add, Value::String(left), Value::Number(right)) => Some(
                Value::String(ValueString(format!("{}{}", left.0, right.0))),
            ),
            (ValueComputedOperation::Add, Value::Number(left), Value::String(right)) => Some(
                Value::String(ValueString(format!("{}{}", left.0, right.0))),
            ),

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
            (ValueComputedOperation::BoolAnd, Value::Number(left), Value::Number(right)) => {
                Some(Value::Boolean(ValueBoolean(
                    left.0 != 0.0 && right.0 != 0.0,
                )))
            }
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
            (ValueComputedOperation::BoolOr, Value::Number(left), Value::Number(right)) => {
                Some(Value::Boolean(ValueBoolean(
                    left.0 != 0.0 || right.0 != 0.0,
                )))
            }
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

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn evaluates_several_computed_variables() {
        let mut evaluator = Evaluator::new();
        assert_eq!(
            evaluator
                .save(Identifier("a".into()), Value::Number(ValueNumber(10.0)))
                .unwrap(),
            Value::Number(ValueNumber(10.0))
        );
        assert_eq!(
            evaluator
                .save(Identifier("b".into()), Value::Number(ValueNumber(5.0)))
                .unwrap(),
            Value::Number(ValueNumber(5.0))
        );

        let sum = Evaluator::apply(
            &ValueComputedOperation::Add,
            &Value::Number(ValueNumber(10.0)),
            &Value::Number(ValueNumber(5.0)),
        );
        assert_eq!(sum, Some(Value::Number(ValueNumber(15.0))));

        let product = Evaluator::apply(
            &ValueComputedOperation::Multiply,
            &Value::Number(ValueNumber(3.0)),
            &Value::Number(ValueNumber(4.0)),
        );
        assert_eq!(product, Some(Value::Number(ValueNumber(12.0))));

        let comparison = Evaluator::apply(
            &ValueComputedOperation::BoolGt,
            &Value::Number(ValueNumber(12.0)),
            &Value::Number(ValueNumber(5.0)),
        );
        assert_eq!(comparison, Some(Value::Boolean(ValueBoolean(true))));
    }

    #[test]
    fn evaluates_nested_computed_variable() {
        let mut evaluator = Evaluator::new();
        evaluator
            .save(Identifier("x".into()), Value::Number(ValueNumber(2.0)))
            .unwrap();
        evaluator
            .save(Identifier("y".into()), Value::Number(ValueNumber(3.0)))
            .unwrap();

        let result = Evaluator::apply(
            &ValueComputedOperation::Add,
            &Value::Number(ValueNumber(2.0)),
            &Value::Number(ValueNumber(3.0)),
        );
        assert_eq!(result, Some(Value::Number(ValueNumber(5.0))));
    }

    #[test]
    fn rejects_division_by_zero_and_invalid_operands() {
        assert!(
            Evaluator::apply(
                &ValueComputedOperation::Divide,
                &Value::Number(ValueNumber(1.0)),
                &Value::Number(ValueNumber(0.0))
            )
            .is_none()
        );
        assert!(
            Evaluator::apply(
                &ValueComputedOperation::Subtract,
                &Value::String(ValueString("a".into())),
                &Value::Number(ValueNumber(1.0)),
            )
            .is_none()
        );
    }
}
