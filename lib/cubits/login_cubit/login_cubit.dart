import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathly/cubits/login_cubit/login_states.dart';
import 'package:pathly/models/auth_response_model.dart';
import 'package:pathly/services/login_service.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoadingLoginState());
  void loginService({required String email, required String password}) async {
    try {
      AuthResponseModel authResponseModel = await LoginService().loginService(
        email: email,
        password: password,
      );
      emit(SuccessLoginState(authResponseModel));
    } catch (e) {
      emit(FailureLoginState(e.toString()));
    }
  }
}
