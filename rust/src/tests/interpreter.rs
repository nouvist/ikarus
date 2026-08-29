use helper::*;

use crate::vpl::{interpreter::Interpreter, raw_tokens::RawScope};

#[tokio::test]
pub async fn interpret_if_properly() {
    let scope_true = RawScope(vec![
        var("Result", str("Foo")),
        if_start(gt(num(4.0), num(3.0))),
        var("Result", str("Bar")),
        end(),
    ]);

    let scope_false = RawScope(vec![
        var("Result", str("Foo")),
        if_start(gt(num(3.0), num(4.0))),
        var("Result", str("Bar")),
        end(),
    ]);

    let mut interpreter = Interpreter::new();
    interpreter.run(scope_true.build().unwrap()).await.unwrap();
    assert_eq!(interpreter.get_variable("Result").unwrap(), str("Bar"));
    interpreter.run(scope_false.build().unwrap()).await.unwrap();
    assert_eq!(interpreter.get_variable("Result").unwrap(), str("Foo"));
}

#[tokio::test]
pub async fn interpret_for_properly() {
    let scope = RawScope(vec![
        var("Iteration", num(0.0)),
        for_start(lt(ident("Iteration"), num(10.0))),
        var("Iteration", add(ident("Iteration"), num(1.0))),
        end(),
    ]);

    let mut interpreter = Interpreter::new();
    interpreter.run(scope.build().unwrap()).await.unwrap();
    assert_eq!(interpreter.get_variable("Iteration").unwrap(), num(10.0));
}

mod helper {
    #![allow(unused)]

    use crate::vpl::{
        functions::FnCall,
        raw_tokens::{RawFor, RawIf, RawStatement},
        tokens::{Identifier, StatementCall, StatementVariable, Value, ValueComputedOperation},
    };

    pub use crate::tests::evaluator::helper::*;

    pub fn if_start(condition: Value) -> RawStatement {
        RawStatement::If(RawIf { condition })
    }

    pub fn for_start(condition: Value) -> RawStatement {
        RawStatement::For(RawFor { condition })
    }

    pub fn end() -> RawStatement {
        RawStatement::End
    }

    pub fn call(call: FnCall) -> RawStatement {
        RawStatement::Call(StatementCall(call))
    }

    pub fn var(ident: &str, value: Value) -> RawStatement {
        RawStatement::Variable(StatementVariable {
            ident: Identifier(ident.to_owned()),
            value,
        })
    }
}
