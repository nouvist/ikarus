use flutter_rust_bridge::frb;

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct FnPrint {
    pub content: String,
}
