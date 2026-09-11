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
    pub mod trimmed_content_ext;
}

pub mod ai {
    pub mod mcp;
    pub mod singleton;
}

#[cfg(windows)]
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

#[cfg(test)]
pub mod tests {
    pub mod evaluator;
    pub mod interpreter;
}

#[frb]
pub fn home() -> &'static Utf8Path {
    static INSTANCE: OnceLock<Utf8PathBuf> = OnceLock::new();
    #[cfg(target_os = "windows")]
    let home = INSTANCE.get_or_init(|| {
        let appdata = env::var("APPDATA").expect("must be exists in Windows environment");
        let mut appdata = Utf8PathBuf::from(appdata);
        appdata.push("ProjectIkarus");
        std::fs::create_dir_all(&appdata).expect("failed to create data directory");
        appdata
    });
    #[cfg(target_os = "linux")]
    let home = INSTANCE.get_or_init(|| {
        let data = env::var("HOME").expect("must be exists in Linux environment");
        let mut data = Utf8PathBuf::from(data);
        data.push(".local/share/ProjectIkarus");
        std::fs::create_dir_all(&data).expect("failed to create data directory");
        data
    });

    home.as_path()
}

#[frb(init)]
pub async fn init_app() {
    _ = home();
    flutter_rust_bridge::setup_default_user_utils();
}
