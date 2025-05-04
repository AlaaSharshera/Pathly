class ResetPassStates {}

class LoadingResetPassState extends ResetPassStates {}

class SuccessResetPassState extends ResetPassStates {
  final String response;
  SuccessResetPassState(this.response);
}

class FailureResetPassState extends ResetPassStates {
  final String errMessage;
  FailureResetPassState(this.errMessage);
}
