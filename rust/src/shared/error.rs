use std::borrow::Cow;

use flutter_rust_bridge::frb;
use rmcp::{ErrorData, model::ErrorCode};
use thiserror::Error;

#[frb(opaque)]
#[derive(Error, Debug)]
pub enum Error {
    #[error("gagal melakukan operasi pada berkas: {0}")]
    IoError(#[from] tokio::io::Error),
    #[error("gagal berkomunikasi dengan peramban: {0}")]
    CdpError(#[from] chromiumoxide::error::CdpError),
    #[error("data gagal diserialisasi ke json: {0}")]
    SerdeJsonError(#[from] serde_json::Error),

    #[error("data gagal diserialisasi")]
    SerializeError,
    #[error("data gagal dideserialisasi")]
    DeserializeError,

    #[error("lingkup tidak memiliki pembuka/penutup yang valid")]
    VplInvalidNested,

    #[error("AI atau MCP gagal diinisialisasi")]
    AiFailedToInitialize,
    #[error("gagal mendapatkan respon: {0}")]
    AiFailedToStream(#[from] rig::agent::StreamingError),
    #[error("gagal melakukan prompt: {0}")]
    AiPromptError(#[from] rig::completion::PromptError),
    #[error("gagal mengekstrak prompt: {0}")]
    AiExtractionError(#[from] rig::extractor::ExtractionError),

    #[error("variabel yang dituju tidak ditemukan")]
    EvaluatorNoVariable,
    #[error("variabel tidak valid untuk dievaluasi")]
    EvaluatorInvalidVariable,

    #[error("peramban gagal dijalankan")]
    BrowserFailedToLaunch,
    #[error("peramban belum dijalankan")]
    BrowserNotRunning,
    #[error("url yang dimasukkan tidak valid")]
    BrowserInvalidUrl,

    #[error("fungsi gagal dideserialisasi")]
    FunctionInvalidDeserialize,
    #[error("{0}")]
    FunctionInvalidArgument(String),
    #[error("{0}")]
    FunctionError(String),
}

impl From<Error> for rmcp::ErrorData {
    fn from(value: Error) -> Self {
        ErrorData {
            code: ErrorCode::default(),
            message: Cow::Owned(format!("{value}")),
            data: None,
        }
    }
}
