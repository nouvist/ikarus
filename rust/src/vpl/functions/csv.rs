use std::sync::Arc;

use async_trait::async_trait;
use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::{
    shared::error::Error,
    vpl::{
        functions::Invoke,
        interpreter::Interpreter,
        tokens::{Value, ValueObject, ValueString},
    },
};

pub fn symbol() -> Value {
    Value::Object(ValueObject {
        symbol: "[Objek Csv]".to_owned(),
    })
}

#[frb(ignore)]
#[derive(Debug, Default, Clone)]
pub struct Csv {
    inner: Vec<Vec<String>>,
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallCsvNew {
    pub csv: Value,
}

#[async_trait]
impl Invoke for FnCallCsvNew {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let csv = self
            .csv
            .unwrap_as_identifier("Csv")?;
        interpreter.store_pointer(csv.0.clone(), Arc::new(Csv::default()));
        interpreter.store_variable(csv, &symbol())?;
        Ok(())
    }
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallCsvGet {
    pub csv: Value,
    pub result: Value,
    pub row: Value,
    pub col: Value,
}

#[async_trait]
impl Invoke for FnCallCsvGet {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let csv = self.csv.unwrap_as_identifier("Csv")?;
        let csv = interpreter.unwrap_pointer::<Csv>(csv)?;
        let result = self.result.unwrap_as_identifier("Hasil")?;
        let row = interpreter
            .evaluate_variable(&self.row)?
            .unwrap_as_number("Baris")?
            .0 as usize;
        let col = interpreter
            .evaluate_variable(&self.col)?
            .unwrap_as_number("Kolom")?
            .0 as usize;

        let Some(row) = csv.inner.get(row) else {
            interpreter.store_variable(result, &Value::Null)?;
            return Ok(());
        };

        let Some(col) = row.get(col) else {
            interpreter.store_variable(result, &Value::Null)?;
            return Ok(());
        };

        interpreter.store_variable(result, &Value::String(ValueString(col.clone())))?;
        Ok(())
    }
}
