import 'dart:developer';

import 'package:dio/dio.dart';

class Api {
  Dio dio = Dio();

  Future<Response> postRequest({
    required String url,
    required body,
    String? token,
  }) async {
    try {
      var response = await dio.post(
        url,
        data: body,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      log(response.toString());
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception("erroe ${response.statusCode}");
      }
    } on DioException catch (e) {
      var errMessage = e.response?.data ?? e.message;
      log(errMessage.toString());
      throw Exception(errMessage);
    }
  }
}
