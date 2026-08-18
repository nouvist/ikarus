use chromiumoxide::{Browser, BrowserConfig, error::CdpError};
use flutter_rust_bridge::frb;
use std::{
    borrow::Cow,
    sync::{Arc, OnceLock},
};
use thiserror::Error;
use tokio::sync::Mutex;
use tokio::task::JoinError;
use tokio_stream::StreamExt;

use crate::{log, win32::window::Window};

#[frb(ignore)]
#[derive(Debug)]
pub struct InnerBrowserSingleton {
    browser: Option<Browser>,
    window: Option<Window>,
    metadata: Option<BrowserMetadata>,
}

#[frb(opaque)]
#[derive(Debug, Clone)]
pub struct BrowserSingleton {
    inner: Arc<Mutex<InnerBrowserSingleton>>,
}

#[frb]
#[derive(Debug, Clone, Copy)]
pub struct BrowserMetadata {
    pub pid: u32,
}

#[frb]
#[derive(Error, Debug)]
pub enum BrowserError {
    #[error("{0}")]
    CdpError(#[from] CdpError),
    #[error("{0}")]
    ChromiumoxideError(Cow<'static, str>),
    #[error("{0}")]
    TokioJoinError(#[from] JoinError),

    #[error("failed to get browser pid")]
    PidError,
}

impl From<String> for BrowserError {
    fn from(value: String) -> Self {
        Self::ChromiumoxideError(Cow::Owned(value))
    }
}

impl From<&'static str> for BrowserError {
    fn from(value: &'static str) -> Self {
        Self::ChromiumoxideError(Cow::Borrowed(value))
    }
}

impl BrowserSingleton {
    #[frb(sync)]
    pub fn frb_override_instance() -> Self {
        Self::instance().clone()
    }

    pub fn instance() -> &'static Self {
        static INSTANCE: OnceLock<BrowserSingleton> = OnceLock::new();
        INSTANCE.get_or_init(|| BrowserSingleton {
            inner: Arc::new(Mutex::new(InnerBrowserSingleton {
                browser: None,
                window: None,
                metadata: None,
            })),
        })
    }

    pub async fn init(&self) -> Result<(), BrowserError> {
        let mut lock = self.inner.lock().await;

        if lock.browser.is_some() {
            log("Chrome sudah berjalan...").await;
            if let Some(window) = lock.window {
                window.focus();
            }
            return Ok(());
        }

        log("Menjalankan Chrome...").await;
        let config = BrowserConfig::builder().with_head().build()?;
        let (mut browser, mut handler) = Browser::launch(config).await?;
        let pid = browser
            .get_mut_child()
            .map(|it| it.inner.id())
            .flatten()
            .ok_or_else(|| BrowserError::PidError)?;

        lock.browser = Some(browser);
        lock.metadata = Some(BrowserMetadata { pid: pid });
        lock.window = Window::from_pid(pid);
        drop(lock);

        let mutex = self.inner.clone();
        tokio::spawn(async move {
            while let Some(h) = handler.next().await {
                if h.is_err() {
                    break;
                }
            }

            let mut lock = mutex.lock().await;
            lock.browser = None;
            lock.metadata = None;
            lock.window = None;
            drop(lock);
        });

        Ok(())
    }
}
