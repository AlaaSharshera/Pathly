import 'dart:developer';

import 'package:pathly/constant.dart';
import 'package:pathly/models/auth_response_model.dart';
import 'package:pathly/utils/api.dart';

class LoginService {
  Future<AuthResponseModel> loginService({
    required String email,
    required String password,
  }) async {
    try {
      var response = await Api().postRequest(
        url: "$baseUrl/Auth/login",
        body: {"email": email, "password": password, "isAdmin": false},
      );
      log(response.data.toString());
      return AuthResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
