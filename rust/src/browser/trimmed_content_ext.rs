use async_trait::async_trait;
use chromiumoxide::Page;
use kuchikiki::{parse_html, traits::TendrilSink};

use crate::shared::{error::Error, error_helper::MapError};

#[async_trait]
pub trait TrimmedContentExt {
    async fn trimmed_content(&self) -> Result<String, Error>;
}

#[async_trait]
impl TrimmedContentExt for Page {
    async fn trimmed_content(&self) -> Result<String, Error> {
        let html = self.content().await?;
        let document = parse_html().one(html);
        for el in document
            .select("style,script,meta,link")
            .map_kuchikiki_failed_to_select()?
        {
            el.as_node().detach();
        }

        Ok(document.to_string())
    }
}
