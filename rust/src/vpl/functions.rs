use std::collections::HashMap;

use async_trait::async_trait;
use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::{
    error::Error,
    impl_fn_call,
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
    [PageFindElement] "Halaman::CariElemen"
        => page: "ref Halaman",
        => element: "out Elemen",
        => selector: "Pemilah";
}

#[frb(ignore)]
#[async_trait]
pub trait Invoke {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error>;
}
