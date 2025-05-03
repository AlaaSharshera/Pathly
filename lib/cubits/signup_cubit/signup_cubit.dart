import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathly/cubits/signup_cubit/signup_states.dart';
import 'package:pathly/models/auth_response_model.dart';
import 'package:pathly/services/signup_service.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(LoadingSignupState());

  void signService({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      AuthResponseModel authResponseModel = await SignupService().signupService(
        username: username,
        email: email,
        password: password,
      );
      emit(SuccessSignupState(authResponseModel));
    } catch (e) {
      emit(FailureSignupState(e.toString()));
    }
  }
}
