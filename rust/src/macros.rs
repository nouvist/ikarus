#[macro_export]
macro_rules! op {
    ($op:ident) => {
        crate::vpl::tokens::Value::ValueComputedOperation::$op
    };
}

#[macro_export]
macro_rules! val {
    ($val:ident $(($($name:tt)+))?) => {
        crate::vpl::tokens::Value::$val$(($($name)+))?
    };
    (ref $val:ident $(($($name:tt)+))?) => { paste::paste! {
        crate::vpl::tokens::Value::$val$((crate::vpl::tokens::[<Value$val>]($($name)+)))?
    } };
}

#[macro_export]
macro_rules! impl_frb_clone {
    ($type:ty) => {
        impl $type {
            #[frb(sync)]
            pub fn frb_override_clone(&self) -> Self {
                self.clone()
            }
        }
    };
}

#[macro_export]
macro_rules! impl_fn_call {
    ($([$type:ident] $name:expr $( => $arg_type:ident : $arg_name:expr),* $(,)?);+ $(;)?) => {
        #[frb]
        #[derive(Debug, Clone, Copy, Serialize, Deserialize, JsonSchema)]
        pub enum FnName {
            $($type,)+
        }

        #[frb]
        #[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
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

#[macro_export]
macro_rules! impl_error_helper {
    ($type:ty where $($name:ident => $subtype:ident $(($arg:ty))?),+ $(,)?) => {
        pub trait MapError<T> {
            $($crate::impl_error_helper!(@map_trait $name, $type $(, $arg)?);)+
        }

        impl<T, E> MapError<T> for Result<T, E> {
            $($crate::impl_error_helper!(@map_impl $name, $type, $subtype $(, $arg)?);)+
        }

        pub trait OkOrError<T> {
            $($crate::impl_error_helper!(@ok_or_trait $name, $type $(, $arg)?);)+
        }

        impl<T> OkOrError<T> for Option<T> {
            $($crate::impl_error_helper!(@ok_or_impl $name, $type, $subtype $(, $arg)?);)+
        }
    };

    (@map_trait $name:ident, $type:ty) => {
        paste::paste! { fn [<map_ $name>](self) -> Result<T, $type>; }
    };
    (@map_trait $name:ident, $type:ty, $arg:ty) => {
        paste::paste! { fn [<map_ $name>](self, msg: $arg) -> Result<T, $type>; }
    };

    (@ok_or_trait $name:ident, $type:ty) => {
        paste::paste! { fn [<ok_or_ $name>](self) -> Result<T, $type>; }
    };
    (@ok_or_trait $name:ident, $type:ty, $arg:ty) => {
        paste::paste! { fn [<ok_or_ $name>](self, msg: $arg) -> Result<T, $type>; }
    };

    (@map_impl $name:ident, $type:ty, $subtype:ident) => {
        paste::paste! {
            fn [<map_ $name>](self) -> Result<T, $type> {
                self.map_err(|_| $type::$subtype)
            }
        }
    };
    (@map_impl $name:ident, $type:ty, $subtype:ident, $arg:ty) => {
        paste::paste! {
            fn [<map_ $name>](self, msg: $arg) -> Result<T, $type> {
                self.map_err(|_| $type::$subtype(msg))
            }
        }
    };

    (@ok_or_impl $name:ident, $type:ty, $subtype:ident) => {
        paste::paste! {
            #[inline]
            fn [<ok_or_ $name>](self) -> Result<T, $type> {
                self.ok_or_else(|| $type::$subtype)
            }
        }
    };
    (@ok_or_impl $name:ident, $type:ty, $subtype:ident, $arg:ty) => {
        paste::paste! {
            #[inline]
            fn [<ok_or_ $name>](self, msg: $arg) -> Result<T, $type> {
                self.ok_or_else(|| $type::$subtype(msg))
            }
        }
    };
}
