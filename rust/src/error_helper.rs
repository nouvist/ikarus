use crate::{error::Error, impl_error_helper};

impl_error_helper! {
    Error where
        serialize_error => SerializeError,
        deserialize_error => DeserializeError,
        vpl_invalid_nested => VplInvalidNested,
        evaluator_no_variable => EvaluatorNoVariable,
        evaluator_invalid_variable => EvaluatorInvalidVariable,
        browser_failed_to_launch => BrowserFailedToLaunch,
        browser_not_running => BrowserNotRunning,
        browser_invalid_url => BrowserInvalidUrl,
        function_invalid_deserialize => FunctionInvalidDeserialize,
        function_invalid_argument => FunctionInvalidArgument(&'static str),
        function_error => FunctionError(&'static str),
}
