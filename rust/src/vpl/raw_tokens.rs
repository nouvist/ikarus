use anyhow::anyhow;
use flutter_rust_bridge::frb;

use crate::vpl::tokens::{Condition, Scope, StCall, StFor, StIf, StVariable, Statement};

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct RawScope(pub Vec<RawStatement>);

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct RawIf {
    pub condition: Condition,
}

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct RawFor {
    pub condition: Condition,
}

#[frb(unignore)]
#[derive(Debug, Clone)]
pub enum RawStatement {
    End,
    If(RawIf),
    For(RawFor),
    Call(StCall),
    Variable(StVariable),
}

impl RawStatement {
    pub fn variant(&self) -> RawStatementVariant {
        match self {
            RawStatement::End => RawStatementVariant::End,
            RawStatement::If(_) => RawStatementVariant::If,
            RawStatement::For(_) => RawStatementVariant::For,
            RawStatement::Variable(_) => RawStatementVariant::Variable,
            RawStatement::Call(it) => RawStatementVariant::Call(match it {
                StCall::Print(_) => RawCallVariant::Print,
            }),
        }
    }
}

impl RawScope {
    pub fn build(self) -> Result<Scope, anyhow::Error> {
        let default_capacity = self.0.len() / 4;
        let mut statements = Vec::<Statement>::with_capacity(default_capacity * 2);
        let mut depth = 0i32;

        fn push_at_depth(
            scope: &mut Vec<Statement>,
            depth: i32,
            next: Statement,
        ) -> Result<(), anyhow::Error> {
            if depth == 0 {
                scope.push(next);
                return Ok(());
            }

            match scope.last_mut() {
                None => Err(anyhow!("invalid nested scopes")),
                Some(Statement::If(it)) => push_at_depth(&mut it.scope.0, depth - 1, next),
                Some(Statement::For(it)) => push_at_depth(&mut it.scope.0, depth - 1, next),
                _ => Err(anyhow!("invalid nested scopes")),
            }
        }

        for statement in self.0 {
            match statement {
                RawStatement::End => {
                    depth -= 1;
                    if depth < 0 {
                        return Err(anyhow!("invalid nested scopes"));
                    }
                }
                RawStatement::If(it) => {
                    push_at_depth(
                        &mut statements,
                        depth,
                        Statement::If(StIf {
                            condition: it.condition,
                            scope: Scope(Vec::with_capacity(default_capacity)),
                        }),
                    )?;
                    depth += 1;
                }
                RawStatement::For(it) => {
                    push_at_depth(
                        &mut statements,
                        depth,
                        Statement::For(StFor {
                            condition: it.condition,
                            scope: Scope(Vec::with_capacity(default_capacity)),
                        }),
                    )?;
                    depth += 1;
                }
                RawStatement::Call(it) => {
                    push_at_depth(&mut statements, depth, Statement::Call(it))?;
                }
                RawStatement::Variable(it) => {
                    push_at_depth(&mut statements, depth, Statement::Variable(it))?;
                }
            }
        }

        if depth != 0 {
            return Err(anyhow!("invalid nested scopes"));
        }

        Ok(Scope(statements))
    }
}

#[frb(unignore)]
pub enum RawStatementVariant {
    End,
    If,
    For,
    Variable,
    Call(RawCallVariant),
}

pub enum RawCallVariant {
    Print,
}
