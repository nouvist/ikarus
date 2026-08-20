use std::{env, sync::OnceLock};

use camino::{Utf8Path, Utf8PathBuf};
use flutter_rust_bridge::{DartFnFuture, frb};
use tokio::spawn;

pub mod frb_generated;

pub mod macros;

pub mod vpl {
    pub mod evaluator;
    pub mod functions;
    pub mod interpreter;
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
        let appdata = env::var("APPDATA").expect("must be exists in Windows environment");
        let mut appdata = Utf8PathBuf::from(appdata);
        appdata.push("ProjectIkarus");
        if !appdata.exists() {
            std::fs::create_dir_all(&appdata).expect("must be user owned in Windows environment");
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
    if let Some(logger) = LOGGER.get() {
        spawn((logger)(str));
    }
}

#[frb(init)]
pub async fn init_app() {
    _ = home();
    flutter_rust_bridge::setup_default_user_utils();
}
