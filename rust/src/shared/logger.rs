use std::{sync::OnceLock, time::Duration};

use flutter_rust_bridge::{DartFnFuture, frb};
use tokio::time::sleep;

static LOGGER: OnceLock<Box<dyn Fn(String) -> DartFnFuture<()> + Send + Sync>> = OnceLock::new();

#[frb]
pub async fn register_logger(
    callback: impl Fn(String) -> DartFnFuture<()> + Send + Sync + 'static,
) {
    _ = LOGGER.set(Box::new(callback));
}

#[frb(ignore)]
pub async fn log(str: impl AsRef<str>) {
    let str = str.as_ref().to_owned();
    let Some(logger) = LOGGER.get() else { return };
    tokio::spawn((logger)(str));
    sleep(Duration::from_millis(5)).await;
}
