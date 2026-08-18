use std::{env, sync::OnceLock};

use camino::{Utf8Path, Utf8PathBuf};
use flutter_rust_bridge::{DartFnFuture, frb};

pub mod frb_generated;

pub mod vpl {
    pub mod functions;
    pub mod raw_tokens;
    pub mod tokens;
}

pub mod ai {
    pub mod settings;
}

pub mod browser {
    pub mod singleton;
}

pub mod win32 {
    pub mod window;
}

#[frb]
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

type DartLogger = Box<dyn Fn(String) -> DartFnFuture<()> + Send + Sync>;
static LOGGER: OnceLock<DartLogger> = OnceLock::new();

#[frb]
pub async fn register_logger(
    callback: impl Fn(String) -> DartFnFuture<()> + Send + Sync + 'static,
) {
    _ = LOGGER.set(Box::new(callback));
}

pub async fn log(str: impl AsRef<str>) {
    let str = str.as_ref().to_owned();
    (LOGGER.get().unwrap())(str).await;
}

#[frb(init)]
pub async fn init_app() {
    _ = home();
    flutter_rust_bridge::setup_default_user_utils();
}
