use crate::vpl::tokens::{Value, ValueObject};

pub fn symbol() -> Value {
    Value::Object(ValueObject {
        symbol: "[Objek Elemen]".to_owned(),
    })
}
