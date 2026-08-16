use flutter_rust_bridge::frb;

use crate::vpl::tokens::Variable;

#[frb]
#[derive(Debug, Clone)]
pub struct FnPrint {
    pub content: Variable,
}
