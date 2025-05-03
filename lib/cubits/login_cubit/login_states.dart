import 'package:pathly/models/auth_response_model.dart';

class LoginStates {}

class LoadingLoginState extends LoginStates {}

class SuccessLoginState extends LoginStates {
  final AuthResponseModel authResponseModel;
  SuccessLoginState(this.authResponseModel);
}

class FailureLoginState extends LoginStates {
  final String errMessage;
  FailureLoginState(this.errMessage);
}
