#[macro_export]
macro_rules! impl_copy {
    ($type:ty) => {
        impl $type {
            #[frb(sync)]
            pub fn copy(&self) -> Self {
                self.clone()
            }
        }
    };
}

#[macro_export]
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
            pub fn apply_args(&self, args: HashMap<String, Value>) -> Result<Self, Error> {
                let mut this = self.clone();
                match &mut this {
                    $(FnCall::$type(it) => {
                        $(it.$arg_type = args
                            .get($arg_name)
                            .ok_or_else(|| Error::FunctionInvalidDeserialize)?
                            .clone();)*
                        _ = it
                    },)+
                }

                Ok(this)
            }

            #[frb(sync)]
            pub fn to_args(&self) -> HashMap<String, Value> {
                match self {
                    $(FnCall::$type(_it) => [$(($arg_name.to_owned(), _it.$arg_type.clone()),)*]
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
            async fn invoke(&self, interpreter: &mut Interpreter) -> Result<(), Error> {
                match self {
                    $(FnCall::$type(it) => it.invoke(interpreter).await?,)+
                }
                Ok(())
            }
        }
    };
}
