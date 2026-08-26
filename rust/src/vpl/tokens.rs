use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::{impl_frb_clone, shared::error::Error, vpl::functions::FnCall};

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, PartialEq, Eq)]
pub struct Identifier(#[frb(non_final)] pub String);
impl_frb_clone!(Identifier);

pub type ValueIdentifier = Identifier;

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, PartialEq, Eq)]
pub struct ValueString(#[frb(non_final)] pub String);
impl_frb_clone!(ValueString);

impl From<String> for ValueString {
    #[inline]
    fn from(value: String) -> Self {
        Self(value)
    }
}

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, PartialEq)]
pub struct ValueNumber(#[frb(non_final)] pub f64);
impl_frb_clone!(ValueNumber);

impl From<f64> for ValueNumber {
    #[inline]
    fn from(value: f64) -> Self {
        Self(value)
    }
}

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, PartialEq, Eq)]
pub struct ValueBoolean(#[frb(non_final)] pub bool);
impl_frb_clone!(ValueBoolean);

impl From<bool> for ValueBoolean {
    #[inline]
    fn from(value: bool) -> Self {
        Self(value)
    }
}

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, PartialEq, Eq)]
pub enum ValueComputedOperation {
    Add,
    Subtract,
    Multiply,
    Divide,
    Modulo,

    BoolAnd,
    BoolOr,

    BoolEqual,
    BoolNotEqual,
    BoolLessThan,
    BoolLessThanOrEqual,
    BoolGreaterThan,
    BoolGreatherThanOrEqual,
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

impl Value {
    pub fn display(&self) -> String {
        match self {
            Value::Null => "Null".to_string(),
            Value::Identifier(it) => format!("[Penunjuk {}]", it.0),
            Value::String(it) => it.0.clone(),
            Value::Number(it) => it.0.to_string(),
            Value::Boolean(it) => match it.0 {
                true => "Benar".to_string(),
                false => "Salah".to_string(),
            },
            Value::Object(it) => it.symbol.clone(),
            Value::Computed(_) => "[Komputasi]".to_string(),
        }
    }

    pub fn boolean(&self) -> bool {
        match self {
            Value::Null => false,
            Value::Identifier(_) => true,
            Value::String(it) => match it.0.to_lowercase() {
                it if it == "benar" => true,
                it if it == "true" => true,
                _ => false,
            },
            Value::Number(it) => it.0 != 0.0,
            Value::Boolean(it) => it.0,
            Value::Object(_) => true,
            Value::Computed(_) => true,
        }
    }
}

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
                        Value::$type(_) => true,
                        _ => false,
                    }
                })+
            }
        }
    };
}

macro_rules! impl_unwrap_as_value {
    ($($identifier:ident => $type:ty [$name:expr]),+$(,)?) => {
        #[frb(ignore)]
        impl Value {
            paste::paste! {
                $(pub fn [<unwrap_as_ $identifier>](
                    &self,
                    name: &'static str
                ) -> Result<&[<Value $type>], Error> {
                    match self {
                        Value::$type(it) => Ok(&it),
                        _ => Err(Error::FunctionInvalidArgument(
                            format!("{} {} {}", name, "harus berupa", $name)
                        )),
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

impl_unwrap_as_value! {
    identifier => Identifier ["rujukan"],
    string => String ["string"],
    number => Number ["angka"],
    boolean => Boolean ["boolean"],
    object => Object ["objek"],
    computed => Computed ["komputasi"],
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
