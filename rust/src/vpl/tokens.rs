use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::{impl_frb_copy, shared::error::Error, vpl::functions::FnCall};

#[frb(non_opaque)]
#[derive(Clone, Serialize, Deserialize, JsonSchema, PartialEq, Eq)]
pub struct Identifier(#[frb(non_final)] pub String);
impl_frb_copy!(Identifier);

pub type ValueIdentifier = Identifier;

#[frb(non_opaque)]
#[derive(Clone, Serialize, Deserialize, JsonSchema, PartialEq, Eq)]
pub struct ValueString(#[frb(non_final)] pub String);
impl_frb_copy!(ValueString);

impl From<String> for ValueString {
    #[inline]
    fn from(value: String) -> Self {
        Self(value)
    }
}

#[frb(non_opaque)]
#[derive(Clone, Serialize, Deserialize, JsonSchema, PartialEq)]
pub struct ValueNumber(#[frb(non_final)] pub f64);
impl_frb_copy!(ValueNumber);

impl From<f64> for ValueNumber {
    #[inline]
    fn from(value: f64) -> Self {
        Self(value)
    }
}

#[frb(non_opaque)]
#[derive(Clone, Serialize, Deserialize, JsonSchema, PartialEq, Eq)]
pub struct ValueBoolean(#[frb(non_final)] pub bool);
impl_frb_copy!(ValueBoolean);

impl From<bool> for ValueBoolean {
    #[inline]
    fn from(value: bool) -> Self {
        Self(value)
    }
}

#[frb(non_opaque)]
#[derive(Clone, Serialize, Deserialize, JsonSchema, PartialEq, Eq)]
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
impl_frb_copy!(ValueComputedOperation);

#[frb(non_opaque)]
#[derive(Clone, Serialize, Deserialize, JsonSchema, PartialEq)]
pub struct ValueComputed {
    #[frb(non_final)]
    pub operation: ValueComputedOperation,
    #[frb(non_final)]
    pub left: Box<Val>,
    #[frb(non_final)]
    pub right: Box<Val>,
}
impl_frb_copy!(ValueComputed);

#[frb(non_opaque)]
#[derive(Clone, Serialize, Deserialize, JsonSchema, PartialEq)]
pub struct ValueObject {
    pub symbol: String,
}
impl_frb_copy!(ValueObject);

#[frb(non_opaque)]
#[derive(Clone, Serialize, Deserialize, JsonSchema, PartialEq)]
pub enum Val {
    Null,
    Identifier(ValueIdentifier),
    String(ValueString),
    Number(ValueNumber),
    Boolean(ValueBoolean),
    Object(ValueObject),
    Computed(Box<ValueComputed>),
}
impl_frb_copy!(Val);

impl Val {
    pub fn display(&self) -> String {
        match self {
            Val::Null => "Null".to_string(),
            Val::Identifier(it) => format!("[Penunjuk {}]", it.0),
            Val::String(it) => it.0.clone(),
            Val::Number(it) => it.0.to_string(),
            Val::Boolean(it) => match it.0 {
                true => "Benar".to_string(),
                false => "Salah".to_string(),
            },
            Val::Object(it) => it.symbol.clone(),
            Val::Computed(_) => "[Komputasi]".to_string(),
        }
    }

    pub fn boolean(&self) -> bool {
        match self {
            Val::Null => false,
            Val::Identifier(_) => true,
            Val::String(it) => match it.0.to_lowercase() {
                it if it == "benar" => true,
                it if it == "true" => true,
                _ => false,
            },
            Val::Number(it) => it.0 != 0.0,
            Val::Boolean(it) => it.0,
            Val::Object(_) => true,
            Val::Computed(_) => true,
        }
    }
}

macro_rules! impl_as_value {
    ($($identifier:ident => $type:ty),+$(,)?) => {
        #[frb(ignore)]
        impl Val {
            paste::paste! {
                $(pub fn [<as_ $identifier>](&self) -> Option<&[<Value $type>]> {
                    match self {
                        Val::$type(it) => Some(&it),
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
        impl Val {
            paste::paste! {
                $(pub fn [<is_ $identifier>](&self) -> bool {
                    match self {
                        Val::$type(_) => true,
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
        impl Val {
            paste::paste! {
                $(pub fn [<unwrap_as_ $identifier>](
                    &self,
                    name: &'static str
                ) -> Result<&[<Value $type>], Error> {
                    match self {
                        Val::$type(it) => Ok(&it),
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

impl Default for Val {
    fn default() -> Self {
        Self::Null
    }
}

#[frb(non_opaque)]
#[derive(Clone, Serialize, Deserialize, JsonSchema)]
pub struct StatementVariable {
    #[frb(non_final)]
    pub ident: Identifier,
    #[frb(non_final)]
    pub value: Val,
}
impl_frb_copy!(StatementVariable);

#[frb(non_opaque)]
#[derive(Clone, Serialize, Deserialize, JsonSchema)]
pub struct StatementCall(#[frb(non_final)] pub FnCall);
impl_frb_copy!(StatementCall);

#[frb(non_opaque)]
#[derive(Clone, Serialize, Deserialize, JsonSchema)]
pub struct StatementIf {
    #[frb(non_final)]
    pub condition: Val,
    #[frb(non_final)]
    pub scope: Scope,
}
impl_frb_copy!(StatementIf);

#[frb(non_opaque)]
#[derive(Clone, Serialize, Deserialize, JsonSchema)]
pub struct StatementFor {
    #[frb(non_final)]
    pub condition: Val,
    #[frb(non_final)]
    pub scope: Scope,
}
impl_frb_copy!(StatementFor);

#[frb(non_opaque)]
#[derive(Clone, Serialize, Deserialize, JsonSchema)]
pub struct Scope(#[frb(non_final)] pub Vec<Statement>);
impl_frb_copy!(Scope);

#[frb(non_opaque)]
#[derive(Clone, Serialize, Deserialize, JsonSchema)]
pub enum Statement {
    If(StatementIf),
    For(StatementFor),
    Call(StatementCall),
    Variable(StatementVariable),
}
impl_frb_copy!(Statement);
