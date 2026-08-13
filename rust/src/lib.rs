use std::time::Duration;

use flutter_rust_bridge::frb;
use thirtyfour::{DesiredCapabilities, WebDriver};

mod frb_generated;

pub mod vpl {
    pub mod dto;
}

pub mod ai {
    pub mod settings;
}

#[frb]
pub async fn launch() -> anyhow::Result<()> {
    let driver = WebDriver::managed(DesiredCapabilities::chrome())
        .await
        .unwrap();
    driver.goto("https://github.com").await?;

    tokio::time::sleep(Duration::from_secs(10)).await;
    driver.quit().await?;
    Ok(())
}

#[frb(init)]
pub fn init_app() {
    flutter_rust_bridge::setup_default_user_utils();
}
