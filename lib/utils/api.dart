import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

class Api {
  Dio dio = Dio();
  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<dynamic> get({required String url}) async {
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('there is an error:${response.statusCode}');
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
    final hasConnection = await checkInternetConnection();
    if (!hasConnection) {
      throw Exception('لا يوجد اتصال بالإنترنت');
    }

    try {
      var response = await dio.post(
        url,
        data: body,
        options: Options(
          contentType: contentType,
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
          'Failed to load data statusCode is:${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw Exception('تعذر الاتصال بالخادم. يرجى التحقق من اتصال الإنترنت');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى');
      } else {
        throw Exception('حدث خطأ غير متوقع: ${e.message}');
      }
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
        throw Exception("error ${response.statusCode}");
      }
    } on DioException catch (e) {
      var errMessage = e.response?.data ?? e.message;
      log(errMessage.toString());
      throw Exception(errMessage);
    }
  }
}
