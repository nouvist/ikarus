use flutter_rust_bridge::frb;

#[frb(unignore)]
pub enum Value {
    #[frb]
    Number(f64),
    #[frb]
    String(String),
    #[frb]
    Boolean(bool),
}

#[frb(unignore)]
pub enum Assignment {
    #[frb]
    Declare { name: String, value: Value },
}
