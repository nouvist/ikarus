use flutter_rust_bridge::frb;
use thiserror::Error;

#[frb(opaque)]
#[derive(Error, Debug)]
pub enum Error {
    #[error("gagal melakukan operasi pada berkas")]
    IoError(#[from] tokio::io::Error),
    #[error("gagal berkomunikasi dengan peramban")]
    CdpError(#[from] chromiumoxide::error::CdpError),

    #[error("gagal menyerialisasi data")]
    SerializeError,
    #[error("gagal mendeserialisasi data")]
    DeserializeError,
    #[error("lingkup tidak memiliki pembuka/penutup yang valid")]
    VplInvalidNested,

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
    Function(&'static str),

}
