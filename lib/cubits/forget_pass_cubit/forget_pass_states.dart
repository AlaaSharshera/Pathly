class ForgetPassStates {}

class LoadingForgetPassState extends ForgetPassStates {}

class SuccessForgetPassState extends ForgetPassStates {
  final String response;
  SuccessForgetPassState(this.response);
}

class FailureForgetPassState extends ForgetPassStates {
  final String errMessage;
  FailureForgetPassState(this.errMessage);
}
