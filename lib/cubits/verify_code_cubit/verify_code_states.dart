class VerifyCodeStates {}

class LoadingVerifyCodeState extends VerifyCodeStates {}

class SuccessVerifyCodeState extends VerifyCodeStates {
  final String response;
  SuccessVerifyCodeState(this.response);
}

class FailureVerifyCodeState extends VerifyCodeStates {
  final String errMessage;
  FailureVerifyCodeState(this.errMessage);
}
