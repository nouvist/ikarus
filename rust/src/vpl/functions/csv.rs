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
        tokens::{Value, ValueNumber, ValueObject, ValueString},
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

#[frb(non_opaque)]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallCsvNew {
    pub csv: Value,
}

#[async_trait]
impl Invoke for FnCallCsvNew {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let csv = self.csv.unwrap_as_identifier("Csv")?;
        interpreter.store_pointer(csv.0.clone(), Arc::new(Csv::default()));
        interpreter.store_variable(csv, &symbol())?;
        Ok(())
    }
}

#[frb(non_opaque)]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallCsvLoad {
    pub csv: Value,
    pub file: Value,
}

#[async_trait]
impl Invoke for FnCallCsvLoad {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let csv_ptr = self.csv.unwrap_as_identifier("Csv")?;
        let file = interpreter.evaluate_variable(&self.file)?;
        let file = file.unwrap_as_string("Berkas")?;
        let mut reader = csv::Reader::from_path(&file.0)?;

        let mut all = Vec::<Vec<String>>::with_capacity(256);

        if let Ok(header) = reader.headers() {
            let mut vec = Vec::<String>::with_capacity(16);
            for cell in header {
                vec.push(cell.to_string());
            }
            all.push(vec);
        }

        for record in reader.records() {
            let record = record?;
            let mut vec = Vec::<String>::with_capacity(record.len());
            for cell in &record {
                vec.push(cell.to_string());
            }
            all.push(vec);
        }

        interpreter.store_pointer(csv_ptr.0.clone(), Arc::new(Csv { inner: all }));
        interpreter.store_variable(csv_ptr, &symbol())?;

        Ok(())
    }
}

#[frb(non_opaque)]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallCsvSave {
    pub csv: Value,
    pub file: Value,
}

#[async_trait]
impl Invoke for FnCallCsvSave {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let csv = self.csv.unwrap_as_identifier("Csv")?;
        let csv = interpreter.unwrap_pointer::<Csv>(csv)?;

        let file = interpreter.evaluate_variable(&self.file)?;
        let file = file.unwrap_as_string("Berkas")?;

        let mut writer = csv::Writer::from_path(&file.0)?;

        for row in &csv.inner {
            writer.write_record(row)?;
        }

        writer.flush()?;

        Ok(())
    }
}

#[frb(non_opaque)]
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

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallCsvSet {
    pub csv: Value,
    pub row: Value,
    pub col: Value,
    pub value: Value,
}

#[async_trait]
impl Invoke for FnCallCsvSet {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let csv_ptr = self.csv.unwrap_as_identifier("Csv")?;
        let csv = interpreter.unwrap_pointer::<Csv>(csv_ptr)?;
        let mut inner = csv.inner.clone();

        let row = interpreter
            .evaluate_variable(&self.row)?
            .unwrap_as_number("Baris")?
            .0 as usize;
        let col = interpreter
            .evaluate_variable(&self.col)?
            .unwrap_as_number("Kolom")?
            .0 as usize;
        let value = interpreter
            .evaluate_variable(&self.value)?
            .unwrap_as_string("Nilai")?
            .0
            .clone();

        if row >= inner.len() {
            inner.resize_with(row + 1, Vec::new);
        }

        if col >= inner[row].len() {
            inner[row].resize_with(col + 1, String::new);
        }
        inner[row][col] = value;

        let max_col = inner.iter().map(|r| r.len()).max().unwrap_or(0);
        for r in inner.iter_mut() {
            if r.len() < max_col {
                r.resize_with(max_col, String::new);
            }
        }

        let csv_write = self.csv.unwrap_as_identifier("Csv")?;
        interpreter.store_pointer(csv_write.0.clone(), Arc::new(Csv { inner }));
        interpreter.store_variable(csv_write, &symbol())?;

        Ok(())
    }
}

#[frb(non_opaque)]
#[derive(Debug, Default, Clone, Serialize, Deserialize, JsonSchema)]
pub struct FnCallCsvRowCount {
    pub csv: Value,
    pub result: Value,
}

#[async_trait]
impl Invoke for FnCallCsvRowCount {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
        let csv_ptr = self.csv.unwrap_as_identifier("Csv")?;
        let csv = interpreter.unwrap_pointer::<Csv>(csv_ptr)?;
        let result_ptr = self.csv.unwrap_as_identifier("Hasil")?;

        interpreter.store_variable(
            result_ptr,
            &Value::Number(ValueNumber(csv.inner.len() as f64)),
        )?;
        Ok(())
    }
}
