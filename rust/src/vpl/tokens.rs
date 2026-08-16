use flutter_rust_bridge::frb;

use crate::vpl::functions::FnPrint;

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct Ident(pub String);

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct VarString(pub String);

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct VarNumber(pub f64);

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct VarBoolean(pub bool);

#[frb(unignore)]
#[derive(Debug, Clone)]
pub enum VarComputedOperation {
    Add,
    Subtract,
    Multiply,
    Divide,
    Reminder,
    And,
    Or,
}

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct VarComputed {
    pub operation: VarComputedOperation,
    pub left: Box<Variable>,
    pub right: Box<Variable>,
}

#[frb(unignore)]
#[derive(Debug, Clone)]
pub enum Variable {
    Null,
    Ident(Ident),
    String(VarString),
    Number(VarNumber),
    Boolean(VarBoolean),
    Computed(Box<VarComputed>),
}

#[frb(unignore)]
#[derive(Debug, Clone)]
pub enum ConditionOperation {
    Not,
    Eq,
    Lt,
    Le,
    Gt,
    Ge,
}

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct ConditionComputed {
    pub operartion: ConditionOperation,
    pub left: Box<Variable>,
    pub right: Box<Variable>,
}

#[frb(unignore)]
#[derive(Debug, Clone)]
pub enum Condition {
    Static(Variable),
    Computed(ConditionComputed),
}

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct StVariable {
    pub ident: Ident,
    pub value: Variable,
}

#[frb(unignore)]
#[derive(Debug, Clone)]
pub enum StCall {
    Print(FnPrint),
}

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct StIf {
    pub condition: Condition,
    pub scope: Scope,
}

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct StFor {
    pub condition: Condition,
    pub scope: Scope,
}

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct Scope(pub Vec<Statement>);

#[frb(unignore)]
#[derive(Debug, Clone)]
pub enum Statement {
    If(StIf),
    For(StFor),
    Call(StCall),
    Variable(StVariable),
}