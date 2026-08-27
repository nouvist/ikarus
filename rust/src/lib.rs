use std::{env, sync::OnceLock};

use camino::{Utf8Path, Utf8PathBuf};
use flutter_rust_bridge::frb;

pub mod frb_generated;

pub mod macros;

pub mod vpl {
    pub mod binding;
    pub mod evaluator;
    pub mod functions;
    pub mod interpreter;
    pub mod raw_tokens;
    pub mod tokens;
}

pub mod browser {
    pub mod singleton;
}

pub mod ai {
    pub mod mcp;
    pub mod singleton;
}

pub mod win32 {
    pub mod window;
}

pub mod shared {
    pub mod abort_controller;
    pub mod error;
    pub mod error_helper;
    pub mod file_dialog;
    pub mod logger;
    pub mod settings;
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

#[frb(init)]
pub async fn init_app() {
    _ = home();
    flutter_rust_bridge::setup_default_user_utils();
}
