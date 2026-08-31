use std::collections::HashMap;

use async_trait::async_trait;
use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::{
    impl_fn_call,
    shared::error::Error,
    vpl::{interpreter::Interpreter, tokens::Value},
};

pub mod system;
use system::*;
pub mod browser;
use browser::*;
pub mod page;
use page::*;
pub mod element;
use element::*;
pub mod csv;
use csv::*;

impl_fn_call! {
    [SystemStop] "Sistem::Berhenti";
    [SystemPrint] "Sistem::Cetak"
        => content: "Konten";
    [SystemSleep] "Sistem::Tidur"
        => ms: "Milidetik";

    [BrowserNewPage] "Peramban::BuatTab"
        => page: "out Halaman",
        => url: "Url";
    [BrowserGetPage] "Peramban::AmbilTab"
        => page: "ref Halaman",
        => index: "Indeks";
    [BrowserGetPageCount] "Peramban::AmbilJumlahTab"
        => result: "out Jumlah";

    [PageWaitForNavigation] "Halaman::TungguNavigasi"
        => page: "ref Halaman";
    [PageClose] "Halaman::Tutup"
        => page: "ref Halaman";
    [PageFindElement] "Halaman::CariElemen"
        => page: "ref Halaman",
        => element: "out Elemen",
        => selector: "Pemilah";

    [ElementGetOuterHtml] "Elemen::AmbilHtmlLuar"
        => element: "ref Elemen",
        => result: "out Hasil";
    [ElementGetInnerHtml] "Elemen::AmbilHtmlDalam"
        => element: "ref Elemen",
        => result: "out Hasil";
    [ElementGetText] "Elemen::AmbilTeks"
        => element: "ref Elemen",
        => result: "out Hasil";
    [ElementType] "Elemen::Ketik"
        => element: "ref Elemen",
        => text: "Teks";
    [ElementClick] "Elemen::Klik"
        => element: "ref Elemen";

    [CsvNew] "Csv::Baru"
        => csv: "out Csv";
    [CsvLoad] "Csv::Buka"
        => csv: "out Csv",
        => file: "Berkas";
    [CsvSave] "Csv::Simpan"
        => csv: "ref Csv",
        => file: "Berkas";
    [CsvGet] "Csv::Ambil"
        => csv: "ref Csv",
        => row: "Baris",
        => col: "Kolom",
        => result: "out Hasil";
    [CsvSet] "Csv::Tulis"
        => csv: "ref Csv",
        => row: "Baris",
        => col: "Kolom",
        => value: "Nilai";
    [CsvRowCount] "Csv::JumlahBaris"
        => csv: "ref Csv",
        => result: "out Hasil";
}

#[frb(ignore)]
#[async_trait]
pub trait Invoke {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error>;
}
