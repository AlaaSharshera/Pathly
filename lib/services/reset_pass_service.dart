import 'dart:developer';

import 'package:pathly/constant.dart';

import 'package:pathly/utils/api.dart';

Future<dynamic> resetPassService({
  required String email,
  required String password,
  required String confirmPassword,
}) async {
  try {
    var response = await Api().postRequest(
      url: "$baseUrl/Auth/reset-password",
      body: {
        "email": email,

        "newPassword": password,
        "confirmPassword": confirmPassword,
      },
    );
    log(response.data.toString());
    return response.data.toString();
  } catch (e) {
    throw Exception(e.toString());
  }
}
