use crate::vpl::evaluator::Evaluator;

use helper::*;

#[tokio::test]
pub async fn evaluate_arithmetic_operations() {
    let mut evaluator = Evaluator::new();

    assert_eq!(
        evaluator.evaluate(&add(num(10.0), num(15.0))).unwrap(),
        num(25.0),
    );
    assert_eq!(
        evaluator.evaluate(&sub(num(10.0), num(15.0))).unwrap(),
        num(-5.0),
    );
    assert_eq!(
        evaluator.evaluate(&mul(num(4.0), num(5.5))).unwrap(),
        num(22.0),
    );
    assert_eq!(
        evaluator.evaluate(&div(num(11.0), num(2.0))).unwrap(),
        num(5.5),
    );
    assert_eq!(
        evaluator.evaluate(&modulo(num(10.0), num(3.0))).unwrap(),
        num(1.0),
    );
}

#[tokio::test]
pub async fn evaluate_string_concatenation() {
    let mut evaluator = Evaluator::new();

    assert_eq!(
        evaluator
            .evaluate(&add(str("halo, "), num(1337f64)))
            .unwrap(),
        str("halo, 1337")
    );
    assert_eq!(
        evaluator
            .evaluate(&add(num(1337f64), str(", halo"),))
            .unwrap(),
        str("1337, halo")
    );
}

#[tokio::test]
pub async fn evaluate_boolean_logic() {
    let mut evaluator = Evaluator::new();

    assert_eq!(
        evaluator.evaluate(&and(bool(true), bool(false))).unwrap(),
        bool(false),
    );
    assert_eq!(
        evaluator.evaluate(&or(bool(true), bool(false))).unwrap(),
        bool(true),
    );
}

#[tokio::test]
pub async fn evaluate_comparisons() {
    let mut evaluator = Evaluator::new();

    assert_eq!(
        evaluator.evaluate(&lt(num(5f64), num(10f64))).unwrap(),
        bool(true),
    );
    assert_eq!(
        evaluator.evaluate(&le(num(10f64), num(10f64))).unwrap(),
        bool(true),
    );
    assert_eq!(
        evaluator.evaluate(&gt(num(15f64), num(10f64))).unwrap(),
        bool(true),
    );
    assert_eq!(
        evaluator.evaluate(&ge(num(10f64), num(5f64))).unwrap(),
        bool(true),
    );
    assert_eq!(
        evaluator.evaluate(&eq(num(42f64), num(42f64))).unwrap(),
        bool(true),
    );
    assert_eq!(
        evaluator.evaluate(&ne(num(42f64), num(99f64))).unwrap(),
        bool(true),
    );
}

#[tokio::test]
pub async fn evaluate_division_by_zero_fails() {
    let mut evaluator = Evaluator::new();

    let division_by_zero = evaluator.evaluate(&div(num(10f64), num(0f64)));
    assert!(division_by_zero.is_err());
}

pub mod helper {
    #![allow(unused)]

    use crate::vpl::tokens::{
        Identifier, Value, ValueBoolean, ValueComputed, ValueComputedOperation, ValueNumber,
        ValueString,
    };

    pub fn str(value: &str) -> Value {
        Value::String(ValueString(value.to_owned()))
    }

    pub fn num(value: f64) -> Value {
        Value::Number(ValueNumber(value))
    }

    pub fn bool(value: bool) -> Value {
        Value::Boolean(ValueBoolean(value))
    }

    pub fn ident(value: &str) -> Value {
        Value::Identifier(Identifier(value.to_owned()))
    }

    pub fn computed(op: ValueComputedOperation, left: Value, right: Value) -> Value {
        Value::Computed(Box::new(ValueComputed {
            operation: op,
            left: Box::new(left),
            right: Box::new(right),
        }))
    }
    pub fn add(left: Value, right: Value) -> Value {
        computed(ValueComputedOperation::Add, left, right)
    }

    pub fn sub(left: Value, right: Value) -> Value {
        computed(ValueComputedOperation::Subtract, left, right)
    }

    pub fn mul(left: Value, right: Value) -> Value {
        computed(ValueComputedOperation::Multiply, left, right)
    }

    pub fn div(left: Value, right: Value) -> Value {
        computed(ValueComputedOperation::Divide, left, right)
    }

    pub fn modulo(left: Value, right: Value) -> Value {
        computed(ValueComputedOperation::Modulo, left, right)
    }

    pub fn and(left: Value, right: Value) -> Value {
        computed(ValueComputedOperation::BoolAnd, left, right)
    }

    pub fn or(left: Value, right: Value) -> Value {
        computed(ValueComputedOperation::BoolOr, left, right)
    }

    pub fn eq(left: Value, right: Value) -> Value {
        computed(ValueComputedOperation::BoolEqual, left, right)
    }

    pub fn ne(left: Value, right: Value) -> Value {
        computed(ValueComputedOperation::BoolNotEqual, left, right)
    }

    pub fn lt(left: Value, right: Value) -> Value {
        computed(ValueComputedOperation::BoolLessThan, left, right)
    }

    pub fn le(left: Value, right: Value) -> Value {
        computed(ValueComputedOperation::BoolLessThanOrEqual, left, right)
    }

    pub fn gt(left: Value, right: Value) -> Value {
        computed(ValueComputedOperation::BoolGreaterThan, left, right)
    }

    pub fn ge(left: Value, right: Value) -> Value {
        computed(ValueComputedOperation::BoolGreatherThanOrEqual, left, right)
    }
}
