use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};

use crate::vpl::tokens::Variable;

macro_rules! helper {
    ($([$type:ident] $name:expr => $($arg_type:ident : $arg:expr),+ $(,)?);+ $(;)?) => {
        #[derive(Debug, Clone, Serialize, Deserialize)]
        pub enum FnName {
            $($type,)+
        }

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
                    $(FnName::$type => FnCall::$type(Default::default()))+
                }
            }

            #[frb(sync)]
            pub fn frb_override_args(&self) -> Vec<String> {
                self.args().iter().map(|it| it.to_string()).collect()
            }

            pub fn args(&self) -> &'static [&'static str] {
                match self {
                    $(FnName::$type => &[$($arg,)+])+
                }
            }

        }
    };
}

helper! {
    [ConsolePrint] "Konsol::Cetak" =>
        content: "konten";
}

#[frb]
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct FnCallConsolePrint {
    pub content: Variable,
}
