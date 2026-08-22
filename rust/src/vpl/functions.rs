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

impl_fn_call! {
    [SystemStop] "Sistem::Berhenti";
    [SystemPrint] "Sistem::Cetak"
        => content: "Konten";
    [SystemSleep] "Sistem::Tidur"
        => ms: "Milidetik";


    [BrowserNewPage] "Peramban::BuatTab"
        => variable: "Variabel",
        => url: "Url";
    [BrowserGetPage] "Peramban::AmbilTab"
        => variable: "Variabel",
        => index: "Indeks";
}

#[frb(ignore)]
#[async_trait]
pub trait Invoke {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error>;
}
