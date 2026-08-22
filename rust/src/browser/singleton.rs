use chromiumoxide::{Browser, BrowserConfig, error::CdpError};
use flutter_rust_bridge::{DartFnFuture, frb};
use std::{
    borrow::Cow,
    sync::{Arc, OnceLock},
};
use thiserror::Error;
use tokio::sync::{RwLock, RwLockReadGuard};
use tokio::task::JoinError;
use tokio_stream::StreamExt;

use crate::{error::Error, log, win32::window::Window};

#[frb(ignore)]
pub struct BrowserSingletonInner {
    browser: Option<Browser>,
    window: Option<Window>,
    pid: Option<u32>,
}

#[frb(opaque)]
#[derive(Clone)]
pub struct BrowserSingleton {
    inner: Arc<RwLock<BrowserSingletonInner>>,
    listener: Arc<RwLock<Option<Box<dyn Fn() -> DartFnFuture<()> + Send + Sync>>>>,
}

impl BrowserSingletonInner {
    #[inline]
    pub fn browser(&self) -> Result<&Browser, Error> {
        self.browser
            .as_ref()
            .ok_or_else(|| Error::BrowserNotRunning)
    }

    #[inline]
    pub async fn is_running(&self) -> bool {
        self.browser.is_some()
    }

    #[inline]
    pub async fn pid(&self) -> Option<u32> {
        self.pid
    }
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
            listener: Arc::new(RwLock::new(None)),
            inner: Arc::new(RwLock::new(BrowserSingletonInner {
                browser: None,
                window: None,
                pid: None,
            })),
        })
    }

    pub async fn init(&self) -> Result<(), BrowserError> {
        let mut lock = self.inner.write().await;

        if lock.browser.is_some() {
            log("[Sistem] Menarik Chrome ke depan...").await;
            if let Some(window) = lock.window {
                window.focus();
            }
            return Ok(());
        }

        log("[Sistem] Menjalankan Chrome...").await;
        let config = BrowserConfig::builder()
            .with_head()
            .viewport(None)
            .build()?;
        let (mut browser, mut handler) = Browser::launch(config).await?;
        let pid = browser
            .get_mut_child()
            .map(|it| it.inner.id())
            .flatten()
            .ok_or_else(|| BrowserError::PidError)?;
        let window = Window::from_pid(pid);

        lock.browser = Some(browser);
        lock.pid = Some(pid);
        lock.window = window;
        drop(lock);
        if let Some(listener) = &*self.listener.read().await {
            (listener)().await;
        }

        let rw = self.inner.clone();
        let listener = self.listener.clone();
        tokio::spawn(async move {
            while let Some(h) = handler.next().await {
                if h.is_err() {
                    break;
                }
            }

            log("[Sistem] Chrome ditutup...").await;
            let mut lock = rw.write().await;
            lock.browser = None;
            lock.pid = None;
            lock.window = None;
            drop(lock);
            if let Some(listener) = &*listener.read().await {
                (listener)().await;
            }
        });

        Ok(())
    }

    pub async fn register_listener(
        &self,
        callback: impl Fn() -> DartFnFuture<()> + Send + Sync + 'static,
    ) {
        let mut listener = self.listener.write().await;
        *listener = Some(Box::new(callback));
    }

    #[inline]
    pub async fn is_running(&self) -> bool {
        self.inner().await.is_running().await
    }

    #[inline]
    pub async fn pid(&self) -> Option<u32> {
        self.inner().await.pid().await
    }

    #[inline]
    #[frb(ignore)]
    pub async fn inner(&self) -> RwLockReadGuard<'_, BrowserSingletonInner> {
        self.inner.read().await
    }
}
