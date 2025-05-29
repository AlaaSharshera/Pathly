import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathly/cubits/reset_pass_cubit/reset_pass_states.dart';
import 'package:pathly/services/reset_pass_service.dart';

class ResetPassCubit extends Cubit<ResetPassStates> {
  ResetPassCubit() : super(LoadingResetPassState());
  void resetPass({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(LoadingResetPassState());
    try {
      String response = await ResetPassService().resetPassService(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      emit(SuccessResetPassState(response));
    } catch (e) {
      emit(FailureResetPassState(e.toString()));
    }
  }
}
