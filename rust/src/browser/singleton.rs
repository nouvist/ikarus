use chromiumoxide::{Browser, BrowserConfig};
use flutter_rust_bridge::{DartFnFuture, frb};
use std::sync::{Arc, OnceLock};
use tokio::sync::{RwLock, RwLockReadGuard};
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

    pub async fn initialize(&self) -> Result<(), Error> {
        let mut inner = self.inner.write().await;

        if inner.browser.is_some() {
            log("[Sistem] Menarik Chrome ke depan...").await;
            if let Some(window) = inner.window {
                window.focus();
            }
            return Ok(());
        }

        log("[Sistem] Menjalankan Chrome...").await;
        let config = BrowserConfig::builder()
            .with_head()
            .viewport(None)
            .build()
            .map_err(|_| Error::BrowserFailedToLaunch)?;
        let (mut browser, mut handler) = Browser::launch(config)
            .await
            .map_err(|_| Error::BrowserFailedToLaunch)?;
        let pid = browser
            .get_mut_child()
            .map(|it| it.inner.id())
            .flatten()
            .ok_or_else(|| Error::BrowserFailedToLaunch)?;
        let window = Window::from_pid(pid);

        inner.browser = Some(browser);
        inner.pid = Some(pid);
        inner.window = window;
        drop(inner);
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
        self.lock().await.is_running().await
    }

    #[inline]
    pub async fn pid(&self) -> Option<u32> {
        self.lock().await.pid().await
    }

    #[inline]
    #[frb(ignore)]
    pub async fn lock(&self) -> RwLockReadGuard<'_, BrowserSingletonInner> {
        self.inner.read().await
    }
}
