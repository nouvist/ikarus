use flutter_rust_bridge::frb;


#[frb(unignore)]
pub enum Value {
    Undefined,
    Number(f64),
    String(String),
    Boolean(bool),
    Element,
}

#[frb(unignore)]
pub enum Variable {
    Identifier(String),
    Value(Value),
}

#[frb(unignore)]
pub enum Condition {
    Not,
    Equal,
    LessThan,
    LessThenOrEqual,
    GreaterThen,
    GreaterThenOrEqual,
}

#[frb(unignore)]
pub enum Statement {
    Assignment {
        identifier: String,
        value: Value,
    },
    If {
        left: Variable,
        right: Variable,
        condition: Condition,
    },
    For {
        left: Variable,
        right: Variable,
        condition: Condition,
    },
    End,
}

#[frb(unignore)]
pub struct Scope(pub Vec<Statement>);
