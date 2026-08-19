use std::collections::HashMap;

use anyhow::anyhow;
use flutter_rust_bridge::frb;

use crate::vpl::tokens::{Ident, VarBoolean, VarComputedOperation, VarNumber, VarString, Variable};

#[frb(opaque)]
pub struct Evaluator {
    pub jar: HashMap<String, Variable>,
}

impl Evaluator {
    pub fn new() -> Self {
        Self {
            jar: HashMap::with_capacity(256),
        }
    }

    pub fn evaluate(&mut self, var: Variable) -> Result<Variable, anyhow::Error> {
        match var {
            Variable::Ident(ident) => {
                let resolved = self
                    .jar
                    .get(&ident.0)
                    .cloned()
                    .ok_or_else(|| anyhow!("variabel yang dirujuk tidak ditemukan"))?;
                Ok(resolved)
            }
            Variable::Computed(it) => {
                let left = self.evaluate(*it.left)?;
                let right = self.evaluate(*it.right)?;

                Evaluator::apply(&it.operation, &left, &right)
                    .ok_or_else(|| anyhow!("variabel tidak valid untuk dievaluasi"))
            }
            it => Ok(it.clone()),
        }
    }

    pub fn save(&mut self, ident: Ident, var: Variable) -> Result<Variable, anyhow::Error> {
        let evaluated = self.evaluate(var)?;
        self.jar.insert(ident.0, evaluated.clone());
        Ok(evaluated)
    }

    fn apply(
        operation: &VarComputedOperation,
        left: &Variable,
        right: &Variable,
    ) -> Option<Variable> {
        match (operation, left, right) {
            // Add
            (VarComputedOperation::Add, Variable::Number(left), Variable::Number(right)) => {
                Some(Variable::Number(VarNumber(left.0 + right.0)))
            }
            (VarComputedOperation::Add, Variable::String(left), Variable::String(right)) => Some(
                Variable::String(VarString(format!("{}{}", left.0, right.0))),
            ),
            (VarComputedOperation::Add, Variable::String(left), Variable::Number(right)) => Some(
                Variable::String(VarString(format!("{}{}", left.0, right.0))),
            ),
            (VarComputedOperation::Add, Variable::Number(left), Variable::String(right)) => Some(
                Variable::String(VarString(format!("{}{}", left.0, right.0))),
            ),

            // Subtract
            (VarComputedOperation::Subtract, Variable::Number(left), Variable::Number(right)) => {
                Some(Variable::Number(VarNumber(left.0 - right.0)))
            }

            // Multiply
            (VarComputedOperation::Multiply, Variable::Number(left), Variable::Number(right)) => {
                Some(Variable::Number(VarNumber(left.0 * right.0)))
            }

            // Divide
            (VarComputedOperation::Divide, Variable::Number(left), Variable::Number(right)) => {
                if right.0 == 0.0 {
                    None
                } else {
                    Some(Variable::Number(VarNumber(left.0 / right.0)))
                }
            }

            // Reminder
            (VarComputedOperation::Reminder, Variable::Number(left), Variable::Number(right)) => {
                if right.0 == 0.0 {
                    None
                } else {
                    Some(Variable::Number(VarNumber(left.0 % right.0)))
                }
            }

            // BoolAnd
            (VarComputedOperation::BoolAnd, Variable::Number(left), Variable::Boolean(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 != 0.0 && right.0)))
            }
            (VarComputedOperation::BoolAnd, Variable::Boolean(left), Variable::Number(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 && right.0 != 0.0)))
            }
            (VarComputedOperation::BoolAnd, Variable::Number(left), Variable::Number(right)) => {
                Some(Variable::Boolean(VarBoolean(
                    left.0 != 0.0 && right.0 != 0.0,
                )))
            }
            (VarComputedOperation::BoolAnd, Variable::Boolean(left), Variable::Boolean(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 && right.0)))
            }

            // BoolOr
            (VarComputedOperation::BoolOr, Variable::Number(left), Variable::Boolean(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 != 0.0 || right.0)))
            }
            (VarComputedOperation::BoolOr, Variable::Boolean(left), Variable::Number(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 || right.0 != 0.0)))
            }
            (VarComputedOperation::BoolOr, Variable::Number(left), Variable::Number(right)) => {
                Some(Variable::Boolean(VarBoolean(
                    left.0 != 0.0 || right.0 != 0.0,
                )))
            }
            (VarComputedOperation::BoolOr, Variable::Boolean(left), Variable::Boolean(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 || right.0)))
            }

            // BoolEq
            (VarComputedOperation::BoolEq, Variable::Boolean(left), Variable::Boolean(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 == right.0)))
            }
            (VarComputedOperation::BoolEq, Variable::Number(left), Variable::Number(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 == right.0)))
            }
            (VarComputedOperation::BoolEq, Variable::String(left), Variable::String(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 == right.0)))
            }

            // BoolLt
            (VarComputedOperation::BoolLt, Variable::Boolean(left), Variable::Boolean(right)) => {
                Some(Variable::Boolean(VarBoolean(!left.0 && right.0)))
            }
            (VarComputedOperation::BoolLt, Variable::Number(left), Variable::Number(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 < right.0)))
            }
            (VarComputedOperation::BoolLt, Variable::String(left), Variable::String(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 < right.0)))
            }

            // BoolLe
            (VarComputedOperation::BoolLe, Variable::Boolean(left), Variable::Boolean(right)) => {
                Some(Variable::Boolean(VarBoolean(!left.0 || right.0)))
            }
            (VarComputedOperation::BoolLe, Variable::Number(left), Variable::Number(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 <= right.0)))
            }
            (VarComputedOperation::BoolLe, Variable::String(left), Variable::String(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 <= right.0)))
            }

            // BoolGt
            (VarComputedOperation::BoolGt, Variable::Boolean(left), Variable::Boolean(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 && !right.0)))
            }
            (VarComputedOperation::BoolGt, Variable::Number(left), Variable::Number(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 > right.0)))
            }
            (VarComputedOperation::BoolGt, Variable::String(left), Variable::String(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 > right.0)))
            }

            // BoolGe
            (VarComputedOperation::BoolGe, Variable::Boolean(left), Variable::Boolean(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 || !right.0)))
            }
            (VarComputedOperation::BoolGe, Variable::Number(left), Variable::Number(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 >= right.0)))
            }
            (VarComputedOperation::BoolGe, Variable::String(left), Variable::String(right)) => {
                Some(Variable::Boolean(VarBoolean(left.0 >= right.0)))
            }

            _ => None,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn number(value: f64) -> Variable {
        Variable::Number(VarNumber(value))
    }

    #[test]
    fn evaluates_several_computed_variables() {
        let mut evaluator = Evaluator::new();
        assert_eq!(
            evaluator.save(Ident("a".into()), number(10.0)).unwrap(),
            number(10.0)
        );
        assert_eq!(
            evaluator.save(Ident("b".into()), number(5.0)).unwrap(),
            number(5.0)
        );

        let sum = Evaluator::apply(&VarComputedOperation::Add, &number(10.0), &number(5.0));
        assert_eq!(sum, Some(number(15.0)));

        let product = Evaluator::apply(&VarComputedOperation::Multiply, &number(3.0), &number(4.0));
        assert_eq!(product, Some(number(12.0)));

        let comparison =
            Evaluator::apply(&VarComputedOperation::BoolGt, &number(12.0), &number(5.0));
        assert_eq!(comparison, Some(Variable::Boolean(VarBoolean(true))));
    }

    #[test]
    fn evaluates_nested_computed_variable() {
        let mut evaluator = Evaluator::new();
        evaluator.save(Ident("x".into()), number(2.0)).unwrap();
        evaluator.save(Ident("y".into()), number(3.0)).unwrap();

        let result = Evaluator::apply(&VarComputedOperation::Add, &number(2.0), &number(3.0));
        assert_eq!(result, Some(number(5.0)));
    }

    #[test]
    fn rejects_division_by_zero_and_invalid_operands() {
        assert!(
            Evaluator::apply(&VarComputedOperation::Divide, &number(1.0), &number(0.0)).is_none()
        );
        assert!(
            Evaluator::apply(
                &VarComputedOperation::Subtract,
                &Variable::String(VarString("a".into())),
                &number(1.0),
            )
            .is_none()
        );
    }
}
