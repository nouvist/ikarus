use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::{impl_frb_clone, vpl::functions::FnCall};

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, PartialEq, Eq)]
pub struct Identifier(#[frb(non_final)] pub String);
impl_frb_clone!(Identifier);

pub type ValueIdentifier = Identifier;

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, PartialEq, Eq)]
pub struct ValueString(#[frb(non_final)] pub String);
impl_frb_clone!(ValueString);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, PartialEq)]
pub struct ValueNumber(#[frb(non_final)] pub f64);
impl_frb_clone!(ValueNumber);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, PartialEq, Eq)]
pub struct ValueBoolean(#[frb(non_final)] pub bool);
impl_frb_clone!(ValueBoolean);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, PartialEq, Eq)]
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
impl_frb_clone!(ValueComputedOperation);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, PartialEq)]
pub struct ValueComputed {
    #[frb(non_final)]
    pub operation: ValueComputedOperation,
    #[frb(non_final)]
    pub left: Box<Value>,
    #[frb(non_final)]
    pub right: Box<Value>,
}
impl_frb_clone!(ValueComputed);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, PartialEq)]
pub struct ValueObject {
    pub symbol: String,
}
impl_frb_clone!(ValueObject);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, PartialEq)]
pub enum Value {
    Null,
    Identifier(ValueIdentifier),
    String(ValueString),
    Number(ValueNumber),
    Boolean(ValueBoolean),
    Object(ValueObject),
    Computed(Box<ValueComputed>),
}
impl_frb_clone!(Value);

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

macro_rules! impl_is_value {
    ($($identifier:ident => $type:ty),+$(,)?) => {
        #[frb(ignore)]
        impl Value {
            paste::paste! {
                $(pub fn [<is_ $identifier>](&self) -> bool {
                    match self {
                        Value::$type(it) => true,
                        _ => false,
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

impl_is_value! {
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
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct StatementVariable {
    #[frb(non_final)]
    pub ident: Identifier,
    #[frb(non_final)]
    pub value: Value,
}
impl_frb_clone!(StatementVariable);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct StatementCall(#[frb(non_final)] pub FnCall);
impl_frb_clone!(StatementCall);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct StatementIf {
    #[frb(non_final)]
    pub condition: Value,
    #[frb(non_final)]
    pub scope: Scope,
}
impl_frb_clone!(StatementIf);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct StatementFor {
    #[frb(non_final)]
    pub condition: Value,
    #[frb(non_final)]
    pub scope: Scope,
}
impl_frb_clone!(StatementFor);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct Scope(#[frb(non_final)] pub Vec<Statement>);
impl_frb_clone!(Scope);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub enum Statement {
    If(StatementIf),
    For(StatementFor),
    Call(StatementCall),
    Variable(StatementVariable),
}
impl_frb_clone!(Statement);
