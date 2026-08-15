use flutter_rust_bridge::frb;

use crate::browser::singleton::{BrowserError, BrowserSingleton};

#[frb(opaque)]
pub struct BrowserFacade;

impl BrowserFacade {
    pub async fn renew() -> Result<(), BrowserError> {
        BrowserSingleton::init_or_renew().await?;
        Ok(())
    }

    pub fn is_running() -> bool {
        BrowserSingleton::global().is_running()
    }
}
