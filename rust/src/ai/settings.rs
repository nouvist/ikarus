use std::{cell::RefCell, sync::OnceLock};

use flutter_rust_bridge::frb;
use tokio::sync::Mutex;

#[frb(unignore)]
#[derive(Debug, Clone)]
pub struct AiSettings {
    pub text_url: String,
    pub text_key: String,
    pub text_model: String,

    pub embed_url: String,
    pub embed_key: String,
    pub embed_model: String,
    pub embed_dimensions: i32,
}

static INSTANCE: OnceLock<Mutex<RefCell<AiSettings>>> = OnceLock::new();

impl AiSettings {
    pub fn empty() -> Self {
        Self {
            text_url: String::from(""),
            text_key: String::from(""),
            text_model: String::from(""),
            embed_url: String::from(""),
            embed_key: String::from(""),
            embed_model: String::from(""),
            embed_dimensions: 768,
        }
    }

    pub async fn current() -> Self {
        let instance = INSTANCE.get_or_init(|| Mutex::new(RefCell::new(Self::empty())));
        let instance = instance.lock().await;
        let instance = instance.borrow();
        instance.clone()
    }

    pub async fn update(self) {
        let instance = INSTANCE.get_or_init(|| Mutex::new(RefCell::new(Self::empty())));
        let mut instance = instance.lock().await;
        let instance = instance.get_mut();

        instance.text_url = self.text_url;
        instance.text_key = self.text_key;
        instance.text_model = self.text_model;

        instance.embed_url = self.embed_url;
        instance.embed_key = self.embed_key;
        instance.embed_model = self.embed_model;
        instance.embed_dimensions = self.embed_dimensions;
    }
}
