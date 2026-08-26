use std::sync::OnceLock;

use flutter_rust_bridge::{DartFnFuture, frb};
use tokio::sync::Mutex;

use crate::vpl::raw_tokens::RawScope;

static SETTER: OnceLock<Mutex<Option<Box<dyn Fn(RawScope) -> DartFnFuture<()> + Send + Sync>>>> =
    OnceLock::new();
static GETTER: OnceLock<Mutex<Option<Box<dyn Fn() -> DartFnFuture<RawScope> + Send + Sync>>>> =
    OnceLock::new();

pub struct RawScopeBinding {}

impl RawScopeBinding {
    #[frb]
    pub async fn register_setter(
        cb: impl Fn(RawScope) -> DartFnFuture<()> + Send + Sync + 'static,
    ) {
        let setter = SETTER.get_or_init(|| Mutex::new(None));
        let mut setter = setter.lock().await;
        *setter = Some(Box::new(cb));
    }

    #[frb]
    pub async fn register_getter(cb: impl Fn() -> DartFnFuture<RawScope> + Send + Sync + 'static) {
        let getter = GETTER.get_or_init(|| Mutex::new(None));
        let mut setter = getter.lock().await;
        *setter = Some(Box::new(cb));
    }

    #[frb(ignore)]
    pub async fn current() -> RawScope {
        macro_rules! unwrap {
            ($($token:tt)+) => {
                $($token)+ else {
                    return RawScope(vec![]);
                };
            };
        }

        unwrap!(let Some(getter) = GETTER.get());
        let getter = getter.lock().await;
        unwrap!(let Some(getter) = getter.as_ref());
        let current = (getter)().await;

        current
    }

    #[frb(ignore)]
    pub async fn update(scope: RawScope) {
        macro_rules! unwrap {
            ($($token:tt)+) => {
                $($token)+ else {
                    return;
                };
            };
        }

        unwrap!(let Some(setter) = SETTER.get());
        let setter = setter.lock().await;
        unwrap!(let Some(setter) = setter.as_ref());
        (setter)(scope).await;
    }
}
