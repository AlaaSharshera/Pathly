import 'dart:developer';

import 'package:pathly/constant.dart';

import 'package:pathly/utils/api.dart';

class ForgetPassService {
  Future<dynamic> forgetPassService({required String email}) async {
    try {
      var response = await Api().postRequest(
        url: "$baseUrl/Auth/forget-password",
        body: {"email": email},
      );
      log(response.data.toString());
      return response.data.toString();
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
