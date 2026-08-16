use flutter_rust_bridge::frb;

use crate::vpl::functions::FnPrint;

#[frb]
#[derive(Debug, Clone)]
pub struct Ident(pub String);

#[frb]
#[derive(Debug, Clone)]
pub struct VarString(pub String);

#[frb]
#[derive(Debug, Clone)]
pub struct VarNumber(pub f64);

#[frb]
#[derive(Debug, Clone)]
pub struct VarBoolean(pub bool);

#[frb]
#[derive(Debug, Clone)]
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

#[frb]
#[derive(Debug, Clone)]
pub struct VarComputed {
    pub operation: VarComputedOperation,
    pub left: Box<Variable>,
    pub right: Box<Variable>,
}

#[frb]
#[derive(Debug, Clone)]
pub enum Variable {
    Null,
    Ident(Ident),
    String(VarString),
    Number(VarNumber),
    Boolean(VarBoolean),
    Computed(Box<VarComputed>),
}

#[frb]
#[derive(Debug, Clone)]
pub struct StVariable {
    pub ident: Ident,
    pub value: Variable,
}

#[frb]
#[derive(Debug, Clone)]
pub enum StCall {
    Print(FnPrint),
}

#[frb]
#[derive(Debug, Clone)]
pub struct StIf {
    pub condition: Variable,
    pub scope: Scope,
}

#[frb]
#[derive(Debug, Clone)]
pub struct StFor {
    pub condition: Variable,
    pub scope: Scope,
}

#[frb]
#[derive(Debug, Clone)]
pub struct Scope(pub Vec<Statement>);

#[frb]
#[derive(Debug, Clone)]
pub enum Statement {
    If(StIf),
    For(StFor),
    Call(StCall),
    Variable(StVariable),
}
