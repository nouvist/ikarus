use anyhow::anyhow;
use chromiumoxide::{Browser, BrowserConfig};
use flutter_rust_bridge::frb;
use tokio_stream::StreamExt;

mod frb_generated;

pub mod vpl {
    pub mod dto;
}

pub mod ai {
    pub mod settings;
}

pub mod browser {
    pub mod singleton;
    pub mod facade;
}

#[frb]
pub async fn launch() -> anyhow::Result<()> {
    let config = BrowserConfig::builder()
        .with_head()
        .build()
        .map_err(|it| anyhow!(it))?;
    let browser = Browser::launch(config);

    let (mut browser, mut handler) = browser.await?;
    let handle = tokio::spawn(async move {
        while let Some(h) = handler.next().await {
            if h.is_err() {
                break;
            }
        }
    });
    let pid = browser
        .get_mut_child()
        .ok_or_else(|| anyhow!("failed to get its pid"))?
        .as_mut_inner()
        .id();

    println!("{pid:?}");

    let page = browser.new_page("https://en.wikipedia.org").await?;

    // page.find_element(".search-toggle").await?.click().await?;

    // page.find_element("input[name='search']")
    //     .await?
    //     .click()
    //     .await?
    //     .type_str("Rust programming language")
    //     .await?
    //     .press_key("Enter")
    //     .await?;

    // let html = page.wait_for_navigation().await?.content().await?;

    // browser.close().await?;
    handle.await?;

    Ok(())
}

#[frb(init)]
pub fn init_app() {
    flutter_rust_bridge::setup_default_user_utils();
}
