use std::collections::HashMap;

use async_trait::async_trait;
use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::vpl::{interpreter::Interpreter, tokens::Value};

pub mod system;
use system::*;

macro_rules! impl_fn_call {
    ($([$type:ident] $name:expr $( => $arg_type:ident : $arg_name:expr),* $(,)?);+ $(;)?) => {
        #[frb]
        #[derive(Debug, Clone, Copy, Serialize, Deserialize)]
        pub enum FnName {
            $($type,)+
        }

        #[frb]
        #[derive(Debug, Clone, Serialize, Deserialize)]
        pub enum FnCall {
            $($type(paste::paste!([<FnCall $type>])),)+
        }

        impl FnCall {
            #[frb(sync)]
            pub fn name(&self) -> FnName {
                match self {
                    $(FnCall::$type(_) => FnName::$type,)+
                }
            }

            pub fn args(&self) -> &'static [&'static str] {
                self.name().args()
            }

            #[frb(sync)]
            pub fn frb_override_args(&self) -> Vec<String> {
                self.args().iter().map(|it| it.to_string()).collect()
            }

            #[frb(sync)]
            pub fn apply_args(&self, args: HashMap<String, Value>) -> Result<Self, anyhow::Error> {
                let mut this = self.clone();
                match &mut this {
                    $(FnCall::$type(it) => {
                        $(it.$arg_type = args
                            .get($arg_name)
                            .ok_or_else(|| anyhow::anyhow!("invalid call"))?
                            .clone();)*
                        _ = it
                    },)+
                }

                Ok(this)
            }

            #[frb(sync)]
            pub fn to_args(&self) -> HashMap<String, Value> {
                match self {
                    $(FnCall::$type(it) => [$(($arg_name.to_owned(), it.$arg_type.clone()),)*]
                        .into_iter()
                        .collect(),)+
                }
            }
        }

        impl FnName {
            #[frb(sync)]
            pub fn frb_override_display(&self) -> String {
                self.display().to_owned()
            }

            pub fn display(&self) -> &'static str {
                match self {
                    $(FnName::$type => $name,)+
                }
            }

            #[frb(sync)]
            pub fn to_call(&self) -> FnCall {
                match self {
                    $(FnName::$type => FnCall::$type(Default::default()),)+
                }
            }

            #[frb(sync)]
            pub fn frb_override_args(&self) -> Vec<String> {
                self.args().iter().map(|it| it.to_string()).collect()
            }

            pub fn args(&self) -> &'static [&'static str] {
                match self {
                    $(FnName::$type => &[$($arg_name,)*],)+
                }
            }
        }

        #[async_trait]
        impl Invoke for FnCall {
            async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), anyhow::Error> {
                match self {
                    $(FnCall::$type(it) => it.invoke(interpreter).await?,)+
                }
                Ok(())
            }
        }
    };
}

impl_fn_call! {
    [SystemPrint] "Sistem::Cetak" =>
        content: "Konten";
    [SystemSleep] "Sistem::Tidur" =>
        ms: "Milidetik";
}

#[frb(ignore)]
#[async_trait]
pub trait Invoke {
    async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), anyhow::Error>;
}
