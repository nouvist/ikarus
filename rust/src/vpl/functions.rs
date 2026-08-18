use std::collections::HashMap;

use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::vpl::tokens::Variable;

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

            #[frb(sync)]
            pub fn apply(&self, args: HashMap<String, Variable>) -> Result<Self, anyhow::Error> {
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
    };
}

impl_fn_call! {
    [ProgramExit] "Program::Tutup";
    [ProgramSleep] "Program::Tidur" =>
        ms: "Milidetik";
    [ConsolePrint] "Konsol::Cetak" =>
        content: "Konten";
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallProgramExit {}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallProgramSleep {
    pub ms: Variable,
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallConsolePrint {
    pub content: Variable,
}
