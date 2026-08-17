use flutter_rust_bridge::frb;

use crate::vpl::functions::FnPrint;

#[frb]
#[derive(Debug, Clone)]
pub struct Ident(#[frb(non_final)] pub String);

#[frb]
#[derive(Debug, Clone)]
pub struct VarString(#[frb(non_final)] pub String);

#[frb]
#[derive(Debug, Clone)]
pub struct VarNumber(#[frb(non_final)] pub f64);

#[frb]
#[derive(Debug, Clone)]
pub struct VarBoolean(#[frb(non_final)] pub bool);

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
    #[frb(non_final)]
    pub operation: VarComputedOperation,
    #[frb(non_final)]
    pub left: Box<Variable>,
    #[frb(non_final)]
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
    #[frb(non_final)]
    pub ident: Ident,
    #[frb(non_final)]
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
    #[frb(non_final)]
    pub condition: Variable,
    #[frb(non_final)]
    pub scope: Scope,
}

#[frb]
#[derive(Debug, Clone)]
pub struct StFor {
    #[frb(non_final)]
    pub condition: Variable,
    #[frb(non_final)]
    pub scope: Scope,
}

#[frb]
#[derive(Debug, Clone)]
pub struct Scope(#[frb(non_final)] pub Vec<Statement>);

#[frb]
#[derive(Debug, Clone)]
pub enum Statement {
    If(StIf),
    For(StFor),
    Call(StCall),
    Variable(StVariable),
}
