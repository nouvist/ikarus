use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::{impl_copy, vpl::functions::FnCall};

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct Identifier(#[frb(non_final)] pub String);
impl_copy!(Identifier);

pub type ValueIdentifier = Identifier;

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct ValueString(#[frb(non_final)] pub String);
impl_copy!(ValueString);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct ValueNumber(#[frb(non_final)] pub f64);
impl_copy!(ValueNumber);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct ValueBoolean(#[frb(non_final)] pub bool);
impl_copy!(ValueBoolean);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub enum ValueComputedOperation {
    Add,
    Subtract,
    Multiply,
    Divide,
    Reminder,

    BoolAnd,
    BoolOr,

    BoolEq,
    BoolLt,
    BoolLe,
    BoolGt,
    BoolGe,
}
impl_copy!(ValueComputedOperation);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct ValueComputed {
    #[frb(non_final)]
    pub operation: ValueComputedOperation,
    #[frb(non_final)]
    pub left: Box<Value>,
    #[frb(non_final)]
    pub right: Box<Value>,
}
impl_copy!(ValueComputed);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub enum ValueObject {
    Csv,
    Element,
}
impl_copy!(ValueObject);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub enum Value {
    Null,
    Identifier(ValueIdentifier),
    String(ValueString),
    Number(ValueNumber),
    Boolean(ValueBoolean),
    Object(ValueObject),
    Computed(Box<ValueComputed>),
}
impl_copy!(Value);

macro_rules! impl_as_value {
    ($($identifier:ident => $type:ty),+$(,)?) => {
        #[frb(ignore)]
        impl Value {
            paste::paste! {
                $(pub fn [<as_ $identifier>](&self) -> Option<&[<Value $type>]> {
                    match self {
                        Value::$type(it) => Some(&it),
                        _ => None,
                    }
                })+
            }
        }
    };
}

impl_as_value! {
    identifier => Identifier,
    string => String,
    number => Number,
    boolean => Boolean,
    object => Object,
    computed => Computed,
}

impl Default for Value {
    fn default() -> Self {
        Self::Null
    }
}

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StatementVariable {
    #[frb(non_final)]
    pub ident: Identifier,
    #[frb(non_final)]
    pub value: Value,
}
impl_copy!(StatementVariable);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StatementCall(#[frb(non_final)] pub FnCall);
impl_copy!(StatementCall);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StatementIf {
    #[frb(non_final)]
    pub condition: Value,
    #[frb(non_final)]
    pub scope: Scope,
}
impl_copy!(StatementIf);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StatementFor {
    #[frb(non_final)]
    pub condition: Value,
    #[frb(non_final)]
    pub scope: Scope,
}
impl_copy!(StatementFor);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Scope(#[frb(non_final)] pub Vec<Statement>);
impl_copy!(Scope);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Statement {
    If(StatementIf),
    For(StatementFor),
    Call(StatementCall),
    Variable(StatementVariable),
}
impl_copy!(Statement);
