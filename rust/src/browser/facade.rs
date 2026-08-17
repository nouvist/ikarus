use flutter_rust_bridge::frb;

use crate::{
    browser::singleton::{BrowserError, BrowserMetadata, BrowserSingleton}, log, win32::window::Window,
};

#[frb(opaque)]
pub struct BrowserFacade;

impl BrowserFacade {
    pub async fn init() -> Result<(), BrowserError> {
        BrowserSingleton::init().await?;
        Ok(())
    }

    #[frb(sync)]
    pub fn is_running() -> bool {
        BrowserSingleton::global().is_running()
    }

    #[frb(sync)]
    pub fn metadata() -> Option<BrowserMetadata> {
        BrowserSingleton::global().metadata()
    }

    #[frb(sync)]
    pub fn window() -> Option<Window> {
        let metadata = BrowserFacade::metadata();
        metadata.map(|it| Window::from_pid(it.pid)).flatten()
    }
}
