use crate::{shared::error::Error, impl_error_helper};

impl_error_helper! {
    Error where
        serialize_error => SerializeError,
        deserialize_error => DeserializeError,
        vpl_invalid_nested => VplInvalidNested,
        ai_failed_to_initialize => AiFailedToInitialize,
        evaluator_no_variable => EvaluatorNoVariable,
        evaluator_invalid_variable => EvaluatorInvalidVariable,
        browser_failed_to_launch => BrowserFailedToLaunch,
        browser_not_running => BrowserNotRunning,
        browser_invalid_url => BrowserInvalidUrl,
        browser_tab_not_found => BrowserTabNotFound,
        function_invalid_deserialize => FunctionInvalidDeserialize,
        function_invalid_argument => FunctionInvalidArgument(String),
        function_error => FunctionError(String),
}

pub trait MapKnownError<T> {
    fn map_known_error(self) -> Result<T, Error>;
}

impl<T, E> MapKnownError<T> for Result<T, E>
where
    E: Into<Error>,
{
    fn map_known_error(self) -> Result<T, Error> {
        self.map_err(|err| err.into())
    }
}
