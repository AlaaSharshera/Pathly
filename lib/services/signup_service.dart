import 'dart:developer';

import 'package:pathly/constant.dart';
import 'package:pathly/models/auth_response_model.dart';
import 'package:pathly/utils/api.dart';

class SignupService {
  Future<AuthResponseModel> signupService({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      var response = await Api().postRequest(
        url: "$baseUrl/Auth/register",
        body: {
          "username": username,
          "email": email,
          "password": password,
          "isAdmin": false,
        },
      );
      log(response.data.toString());
      return AuthResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
