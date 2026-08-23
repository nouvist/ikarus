use flutter_rust_bridge::frb;

use crate::{
    error::Error,
    vpl::{
        interpreter::Interpreter,
        tokens::{Identifier, Value},
    },
};

#[frb(ignore)]
pub trait ValueUnwrapAsIdentifier {
    fn unwrap_as_identifier(&self) -> Result<&Identifier, Error>;
}

#[frb(ignore)]
impl ValueUnwrapAsIdentifier for Value {
    fn unwrap_as_identifier(&self) -> Result<&Identifier, Error> {
        self.as_identifier()
            .ok_or_else(|| Error::FunctionInvalidArgument("Variabel harus berupa rujukan"))
    }
}

#[frb(ignore)]
pub trait IdentifierUnwrapPointer {
    fn unwrap_pointer<'a, T: 'static>(
        &'a self,
        interpreter: &'a mut Interpreter,
    ) -> Result<&'a T, Error>;
}
