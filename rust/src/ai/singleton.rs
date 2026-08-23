use std::sync::{Arc, OnceLock};

use flutter_rust_bridge::frb;
use rig::{client::AgentClientExt, completion::Prompt, providers::openai};
use tokio::sync::RwLock;

use crate::{ai::settings::AiSettings, error::Error};

#[frb(ignore)]
pub struct AiSingletonInner {
    text_generation: Option<openai::Client>,
    text_embedding: Option<openai::Client>,
}

#[frb(opaque)]
#[derive(Clone)]
pub struct AiSingleton {
    inner: Arc<RwLock<AiSingletonInner>>,
}

impl AiSingleton {
    #[frb(sync)]
    pub fn frb_override_instance() -> Self {
        Self::instance().clone()
    }

    pub fn instance() -> &'static Self {
        static INSTANCE: OnceLock<AiSingleton> = OnceLock::new();
        INSTANCE.get_or_init(|| AiSingleton {
            inner: Arc::new(RwLock::new(AiSingletonInner {
                text_generation: None,
                text_embedding: None,
            })),
        })
    }

    pub async fn initialize(&self) -> Result<(), Error> {
        let mut inner = self.inner.write().await;
        let settings = AiSettings::current().await;
        let text_generation = openai::Client::builder()
            .base_url(settings.text_url)
            .api_key(settings.text_key)
            .build()
            .map_err(|_| Error::AiFailedToInitialize)?;
        let text_embedding = openai::Client::builder()
            .base_url(settings.embed_url)
            .api_key(settings.embed_key)
            .build()
            .map_err(|_| Error::AiFailedToInitialize)?;
        _ = inner.text_generation.insert(text_generation);
        _ = inner.text_embedding.insert(text_embedding);
        Ok(())
    }
}
