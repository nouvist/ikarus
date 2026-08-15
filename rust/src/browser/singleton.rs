use chromiumoxide::{Browser, BrowserConfig, error::CdpError};
use flutter_rust_bridge::frb;
use std::{
    borrow::Cow,
    ops::{Deref, DerefMut},
    sync::OnceLock,
};
use thiserror::Error;
use tokio::sync::{Mutex, MutexGuard, watch};
use tokio::task::JoinError;
use tokio_stream::StreamExt;

#[frb(ignore)]
#[derive(Debug)]
pub struct BrowserSingleton {
    browser: Mutex<Option<Browser>>,
    is_running_tx: watch::Sender<bool>,
    is_running_rx: watch::Receiver<bool>,
}

#[frb(unignore)]
#[derive(Error, Debug)]
pub enum BrowserError {
    #[error("{0}")]
    CdpError(#[from] CdpError),
    #[error("{0}")]
    ChromiumoxideError(Cow<'static, str>),
    #[error("{0}")]
    TokioJoinError(#[from] JoinError),
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

pub struct BrowserGuard<'a>(MutexGuard<'a, Option<Browser>>);

impl<'a> Deref for BrowserGuard<'a> {
    type Target = Browser;
    fn deref(&self) -> &Browser {
        self.0.as_ref().unwrap()
    }
}
impl<'a> DerefMut for BrowserGuard<'a> {
    fn deref_mut(&mut self) -> &mut Browser {
        self.0.as_mut().unwrap()
    }
}

impl BrowserSingleton {
    pub fn global() -> &'static Self {
        static INSTANCE: OnceLock<BrowserSingleton> = OnceLock::new();
        INSTANCE.get_or_init(|| {
            let (is_running_tx, is_running_rx) = watch::channel(false);
            BrowserSingleton {
                browser: Mutex::new(None),
                is_running_tx,
                is_running_rx,
            }
        })
    }

    pub async fn init_or_renew() -> Result<(), BrowserError> {
        let this = Self::global();
        if this.is_running() {
            return Ok(());
        }

        let config = BrowserConfig::builder().with_head().build()?;
        let (browser, mut handler) = Browser::launch(config).await?;

        {
            let mut guard = this.browser.lock().await;
            *guard = Some(browser);
        }

        let tx = this.is_running_tx.clone();
        tokio::spawn(async move {
            let _ = tx.send(true);
            while let Some(h) = handler.next().await {
                if h.is_err() {
                    break;
                }
            }
            let _ = tx.send(false);
        });

        Ok(())
    }

    pub async fn browser(&self) -> Result<BrowserGuard<'_>, BrowserError> {
        let guard = self.browser.lock().await;
        if guard.is_none() {
            return Err("browser not initialized".into());
        }
        Ok(BrowserGuard(guard))
    }

    #[inline]
    pub fn is_running(&self) -> bool {
        *self.is_running_rx.borrow()
    }
}
