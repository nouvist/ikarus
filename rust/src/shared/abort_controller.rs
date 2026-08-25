use std::sync::Arc;

use flutter_rust_bridge::frb;
use tokio_util::sync::CancellationToken;

use crate::impl_frb_clone;

#[frb(opaque)]
#[derive(Clone)]
pub struct AbortController(Arc<CancellationToken>);

impl AbortController {
    #[frb(sync)]
    pub fn new() -> Self {
        Self(Arc::new(CancellationToken::new()))
    }

    #[frb(sync)]
    pub fn abort(&self) {
        self.0.cancel();
    }

    #[inline]
    #[frb(ignore)]
    pub async fn run_until_cancelled<F>(&self, fut: F) -> Option<F::Output>
    where
        F: Future,
    {
        self.0.run_until_cancelled(fut).await
    }
}

impl_frb_clone!(AbortController);
