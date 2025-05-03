import 'package:pathly/models/auth_response_model.dart';

class SignupState {}

class LoadingSignupState extends SignupState {}

class SuccessSignupState extends SignupState {
  AuthResponseModel authResponseModel;
  SuccessSignupState(this.authResponseModel);
}

class FailureSignupState extends SignupState {
  final String errMessage;
  FailureSignupState(this.errMessage);
}
