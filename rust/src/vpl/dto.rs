use flutter_rust_bridge::frb;


#[frb(unignore)]
pub enum DtoValue {
    Undefined,
    Number(f64),
    String(String),
    Boolean(bool),
    Element,
}

#[frb(unignore)]
pub enum DtoVariable {
    Identifier(String),
    Value(DtoValue),
}

#[frb(unignore)]
pub enum DtoCondition {
    Not,
    Equal,
    LessThan,
    LessThenOrEqual,
    GreaterThen,
    GreaterThenOrEqual,
}

#[frb(unignore)]
pub enum DtoStatement {
    Assignment {
        identifier: String,
        value: DtoValue,
    },
    If {
        left: DtoVariable,
        right: DtoVariable,
        condition: DtoCondition,
    },
    For {
        left: DtoVariable,
        right: DtoVariable,
        condition: DtoCondition,
    },
    End,
}

#[frb(unignore)]
pub struct DtoScope(pub Vec<DtoStatement>);
