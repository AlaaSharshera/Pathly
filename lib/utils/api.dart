import 'dart:developer';

import 'package:dio/dio.dart';

class Api {
  Dio dio = Dio();
   Future<dynamic> get({required String url}) async {
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          'Failed to load subscription plans statusCode is:${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      var errMessage = e.response?.data ?? e.message;
      throw Exception(errMessage.toString());
    }
  }


  Future<Response> postStripe({
    required String url,
    required String token,
    required body,
    String? contentType,
  }) async {
    var response = await dio.post(
      url,
      data: body,
      options: Options(
        contentType: contentType,
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return response;
  }

 
  Future<dynamic> post({
    required String url,
    required String token,
    required body,
    String? contentType,
  }) async {
    try {
      var response = await dio.post(
        url,
        data: body,
        options: Options(
          contentType: contentType,
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          'Failed to load subscription plans statusCode is:${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      var errMessage = e.response?.data ?? e.message;
      throw Exception(errMessage.toString());
    }
  }

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
