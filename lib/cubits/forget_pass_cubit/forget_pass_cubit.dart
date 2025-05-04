import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathly/cubits/forget_pass_cubit/forget_pass_states.dart';
import 'package:pathly/services/forget_pass_service.dart';

class ForgetPassCubit extends Cubit<ForgetPassStates> {
  ForgetPassCubit() : super(LoadingForgetPassState());
  void forgetPassService({required String email}) async {
    emit(LoadingForgetPassState());
    try {
      String response = await ForgetPassService().forgetPassService(
        email: email,
      );
      log(SuccessForgetPassState(response).toString());
      emit(SuccessForgetPassState(response));
    } catch (e) {
      log(e.toString());
      emit(FailureForgetPassState(e.toString()));
    }
  }
}
