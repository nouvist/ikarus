use std::borrow::Cow;

use flutter_rust_bridge::frb;
use rmcp::{ErrorData, model::ErrorCode};
use thiserror::Error;

#[frb(opaque)]
#[derive(Error, Debug)]
pub enum Error {
    #[error("gagal melakukan operasi pada berkas")]
    IoError(#[from] tokio::io::Error),
    #[error("gagal berkomunikasi dengan peramban")]
    CdpError(#[from] chromiumoxide::error::CdpError),
    #[error("data gagal diserialisasi ke json")]
    SerdeJsonError(#[from] serde_json::Error),

    #[error("data gagal diserialisasi")]
    SerializeError,
    #[error("data gagal dideserialisasi")]
    DeserializeError,

    #[error("lingkup tidak memiliki pembuka/penutup yang valid")]
    VplInvalidNested,

    #[error("lingkup tidak memiliki pembuka/penutup yang valid")]
    AiFailedToInitialize,

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
    FunctionInvalidArgument(&'static str),
    #[error("{0}")]
    FunctionError(&'static str),
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
