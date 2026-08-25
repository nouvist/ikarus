use std::sync::OnceLock;

use serde::{Deserialize, Serialize};
use tokio::{fs, sync::RwLock};

use crate::{
    home,
    shared::{error::Error, error_helper::MapError},
};

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Settings {
    pub text_generation_url: String,
    pub text_generation_key: String,
    pub text_generation_model: String,
}

static INSTANCE: OnceLock<RwLock<Settings>> = OnceLock::new();
impl Settings {
    fn instance() -> &'static RwLock<Settings> {
        INSTANCE.get_or_init(|| {
            let path = home().join("settiings.dat");
            if path.exists()
                && let Ok(file) = std::fs::read(path)
            {
                let settings = postcard::from_bytes::<Settings>(&file);
                if let Ok(settings) = settings {
                    return RwLock::new(settings);
                }
            }

            RwLock::new(Self {
                text_generation_url: "".to_string(),
                text_generation_key: "".to_string(),
                text_generation_model: "".to_string(),
            })
        })
    }

    pub async fn current() -> Settings {
        let instance = Self::instance().read().await;
        instance.clone()
    }

    pub async fn save(&self) -> Result<(), Error> {
        let buffer = postcard::to_allocvec(self).map_deserialize_error()?;
        let mut instance = Self::instance().write().await;
        fs::write(home().join("settings.dat"), buffer).await?;
        *instance = self.clone();

        Ok(())
    }
}
