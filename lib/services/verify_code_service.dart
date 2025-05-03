import 'dart:developer';

import 'package:pathly/constant.dart';

import 'package:pathly/utils/api.dart';

Future<dynamic> verifyCodeService({
  required String email,
  required String code,
}) async {
  try {
    var response = await Api().postRequest(
      url: "$baseUrl/Auth/verify-code",
      body: {"email": email, "code": code},
    );
    log(response.data.toString());
    return response.data.toString();
  } catch (e) {
    throw Exception(e.toString());
  }
}
