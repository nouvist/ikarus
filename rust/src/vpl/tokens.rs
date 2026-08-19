use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::{impl_copy, vpl::functions::FnCall};

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Ident(#[frb(non_final)] pub String);
impl_copy!(Ident);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VarString(#[frb(non_final)] pub String);
impl_copy!(VarString);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VarNumber(#[frb(non_final)] pub f64);
impl_copy!(VarNumber);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VarBoolean(#[frb(non_final)] pub bool);
impl_copy!(VarBoolean);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum VarComputedOperation {
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
impl_copy!(VarComputedOperation);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VarComputed {
    #[frb(non_final)]
    pub operation: VarComputedOperation,
    #[frb(non_final)]
    pub left: Box<Variable>,
    #[frb(non_final)]
    pub right: Box<Variable>,
}
impl_copy!(VarComputed);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Entity {
    Csv,
    Element,
}
impl_copy!(Entity);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Variable {
    Null,
    Ident(Ident),
    String(VarString),
    Number(VarNumber),
    Boolean(VarBoolean),
    Entity(Entity),
    Computed(Box<VarComputed>),
}
impl_copy!(Variable);

impl Default for Variable {
    fn default() -> Self {
        Self::Null
    }
}

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StVariable {
    #[frb(non_final)]
    pub ident: Ident,
    #[frb(non_final)]
    pub value: Variable,
}
impl_copy!(StVariable);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StCall(#[frb(non_final)] pub FnCall);
impl_copy!(StCall);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StIf {
    #[frb(non_final)]
    pub condition: Variable,
    #[frb(non_final)]
    pub scope: Scope,
}
impl_copy!(StIf);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StFor {
    #[frb(non_final)]
    pub condition: Variable,
    #[frb(non_final)]
    pub scope: Scope,
}
impl_copy!(StFor);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Scope(#[frb(non_final)] pub Vec<Statement>);
impl_copy!(Scope);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Statement {
    If(StIf),
    For(StFor),
    Call(StCall),
    Variable(StVariable),
}
impl_copy!(Statement);
