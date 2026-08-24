use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::{
    error::Error,
    error_helper::MapError,
    impl_frb_clone, log,
    vpl::{
        functions::FnName,
        tokens::{
            Scope, Statement, StatementCall, StatementFor, StatementIf, StatementVariable, Value,
        },
    },
};

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct RawScope(#[frb(non_final)] pub Vec<RawStatement>);
impl_frb_clone!(RawScope);

impl RawScope {
    #[frb(sync)]
    pub fn from_binary(binary: Vec<u8>) -> Result<Self, Error> {
        let result = postcard::from_bytes::<Self>(&binary).map_deserialize_error()?;
        Ok(result)
    }

    #[frb(sync)]
    pub fn from_json(json: String) -> Result<Self, Error> {
        let result = serde_json::from_str(&json).map_deserialize_error()?;
        Ok(result)
    }

    #[frb(sync)]
    pub fn to_binary(&self) -> Result<Vec<u8>, Error> {
        let result = postcard::to_allocvec(self).map_deserialize_error()?;
        Ok(result)
    }

    #[frb(sync)]
    pub fn to_json(&self) -> Result<String, Error> {
        let result = serde_json::to_string(self).map_deserialize_error()?;
        Ok(result)
    }
}

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct RawIf {
    #[frb(non_final)]
    pub condition: Value,
}
impl_frb_clone!(RawIf);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct RawFor {
    #[frb(non_final)]
    pub condition: Value,
}
impl_frb_clone!(RawFor);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub enum RawStatement {
    End,
    If(RawIf),
    For(RawFor),
    Call(StatementCall),
    Variable(StatementVariable),
}
impl_frb_clone!(RawStatement);

#[frb]
#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub enum RawStatementVariant {
    End,
    If,
    For,
    Variable,
    Call(FnName),
}
impl_frb_clone!(RawStatementVariant);

impl RawStatement {
    pub fn variant(&self) -> RawStatementVariant {
        match self {
            RawStatement::End => RawStatementVariant::End,
            RawStatement::If(_) => RawStatementVariant::If,
            RawStatement::For(_) => RawStatementVariant::For,
            RawStatement::Variable(_) => RawStatementVariant::Variable,
            RawStatement::Call(it) => RawStatementVariant::Call(it.0.name()),
        }
    }
}

impl RawScope {
    pub async fn frb_override_build(self) -> Result<Scope, Error> {
        let result = self.build();
        if let Err(err) = &result {
            log(format!("[Sistem] Galat: {err}.")).await;
        }

        result
    }

    #[frb(sync)]
    pub fn build(self) -> Result<Scope, Error> {
        let default_capacity = self.0.len() / 4;
        let mut statements = Vec::<Statement>::with_capacity(default_capacity * 2);
        let mut depth = 0i32;

        fn push(scope: &mut Vec<Statement>, depth: i32, next: Statement) -> Result<(), Error> {
            if depth == 0 {
                scope.push(next);
                return Ok(());
            }

            match scope.last_mut() {
                None => Err(Error::VplInvalidNested),
                Some(Statement::If(it)) => push(&mut it.scope.0, depth - 1, next),
                Some(Statement::For(it)) => push(&mut it.scope.0, depth - 1, next),
                _ => Err(Error::VplInvalidNested),
            }
        }

        for statement in self.0 {
            match statement {
                RawStatement::End => {
                    depth -= 1;
                    if depth < 0 {
                        return Err(Error::VplInvalidNested);
                    }
                }
                RawStatement::If(it) => {
                    push(
                        &mut statements,
                        depth,
                        Statement::If(StatementIf {
                            condition: it.condition,
                            scope: Scope(Vec::with_capacity(default_capacity)),
                        }),
                    )?;
                    depth += 1;
                }
                RawStatement::For(it) => {
                    push(
                        &mut statements,
                        depth,
                        Statement::For(StatementFor {
                            condition: it.condition,
                            scope: Scope(Vec::with_capacity(default_capacity)),
                        }),
                    )?;
                    depth += 1;
                }
                RawStatement::Call(it) => {
                    push(&mut statements, depth, Statement::Call(it))?;
                }
                RawStatement::Variable(it) => {
                    push(&mut statements, depth, Statement::Variable(it))?;
                }
            }
        }

        if depth != 0 {
            return Err(Error::VplInvalidNested);
        }

        Ok(Scope(statements))
    }
}
