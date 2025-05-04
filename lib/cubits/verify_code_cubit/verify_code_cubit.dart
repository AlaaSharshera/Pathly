import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathly/cubits/verify_code_cubit/verify_code_states.dart';
import 'package:pathly/services/verify_code_service.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeStates> {
  VerifyCodeCubit() : super(LoadingVerifyCodeState());
  void verifyCode({required String email, required String code}) async {
    emit(LoadingVerifyCodeState());
    try {
      String response = await VerifyCodeService().verifyCodeService(
        email: email,
        code: code,
      );
      log(SuccessVerifyCodeState(response).toString());
      emit(SuccessVerifyCodeState(response));
    } catch (e) {
      log(e.toString());
      emit(FailureVerifyCodeState(e.toString()));
    }
  }
}
