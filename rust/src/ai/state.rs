use flutter_rust_bridge::frb;
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};

use crate::impl_enum_is;

#[derive(Debug, Clone)]
pub enum AiState {
    Start(AiStateStart),
    Answer(AiStateAnswer),
    Plan(AiStatePlan),
}

#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct AiStateStart {
    pub decision: AiStateStartDecision,
}

#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub enum AiStateStartDecision {
    AnswerImmediately,
    PlanForAlgorithm,
}

impl_enum_is! {
    AiStateStartDecision where
        answer_immediately => AnswerImmediately,
        plan_for_advance_tasks => PlanForAlgorithm,
}

#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct AiStateAnswer {
    pub message: String,
}

#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema)]
pub struct AiStatePlan {
    pub plans: Vec<String>,
}
