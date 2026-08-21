use flutter_rust_bridge::frb;
use rig::serde::{Deserialize, Serialize};
use tokio::fs;

use crate::{error::Error, home};

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

impl AiSettings {
    #[frb(sync)]
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
        let Ok(file) = fs::read(home().join("ai.dat")).await else {
            #[cfg(debug_assertions)]
            println!("file ai.dat gagal dibaca");
            return Self::empty();
        };

        let Ok(file) = postcard::from_bytes::<AiSettingsSerde>(&file) else {
            #[cfg(debug_assertions)]
            println!("file ai.dat gagal dipetakan");
            return Self::empty();
        };

        file.to_raw()
    }

    pub async fn update(self) -> Result<(), Error> {
        let mut instance = Self::current().await;

        instance.text_url = self.text_url;
        instance.text_key = self.text_key;
        instance.text_model = self.text_model;

        instance.embed_url = self.embed_url;
        instance.embed_key = self.embed_key;
        instance.embed_model = self.embed_model;
        instance.embed_dimensions = self.embed_dimensions;

        let buf = postcard::to_allocvec(&AiSettingsSerde::new(&instance))
            .map_err(|_| Error::SerializeError)?;
        fs::write(home().join("ai.dat"), buf).await?;

        Ok(())
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
struct AiSettingsSerde {
    text_url: String,
    text_key: String,
    text_model: String,

    embed_url: String,
    embed_key: String,
    embed_model: String,
    embed_dimensions: i32,
}

impl AiSettingsSerde {
    fn new(value: &AiSettings) -> Self {
        Self {
            text_url: value.text_url.to_owned(),
            text_key: value.text_key.to_owned(),
            text_model: value.text_model.to_owned(),
            embed_url: value.embed_url.to_owned(),
            embed_key: value.embed_key.to_owned(),
            embed_model: value.embed_model.to_owned(),
            embed_dimensions: value.embed_dimensions.to_owned(),
        }
    }

    fn to_raw(&self) -> AiSettings {
        AiSettings {
            text_url: self.text_url.to_owned(),
            text_key: self.text_key.to_owned(),
            text_model: self.text_model.to_owned(),
            embed_url: self.embed_url.to_owned(),
            embed_key: self.embed_key.to_owned(),
            embed_model: self.embed_model.to_owned(),
            embed_dimensions: self.embed_dimensions.to_owned(),
        }
    }
}
