use std::{env, sync::OnceLock};

use anyhow::anyhow;
use camino::{Utf8Path, Utf8PathBuf};
use chromiumoxide::{Browser, BrowserConfig};
use flutter_rust_bridge::frb;
use tokio_stream::StreamExt;

pub mod frb_generated;

pub mod vpl {
    pub mod dto {
        pub mod functions;
        pub mod primitives;
    }
}

pub mod ai {
    pub mod settings;
}

pub mod browser {
    pub mod facade;
    pub mod singleton;
}

pub fn home() -> &'static Utf8Path {
    static INSTANCE: OnceLock<Utf8PathBuf> = OnceLock::new();
    let home = INSTANCE.get_or_init(|| {
        let appdata = env::var("APPDATA").unwrap();
        let mut appdata = Utf8PathBuf::from(appdata);
        appdata.push("ProjectIkarus");
        if !appdata.exists() {
            std::fs::create_dir_all(&appdata).unwrap();
        }
        appdata
    });

    home.as_path()
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
    let _ = home();
    flutter_rust_bridge::setup_default_user_utils();
}
