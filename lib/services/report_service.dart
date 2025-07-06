import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pathly/utils/api_keys.dart';

class ReportService {
  final Dio dio = Dio();
  Future post({
    required String url,
    required String token,
    required String contentType,
    required body,
  }) async {
    try {
      var response = await dio.post(
        url,
        options: Options(
          contentType: contentType,
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: body,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return response;
      }
    } on DioException catch (e) {
      var errMessage = e.response?.data ?? e.message;
      throw Exception(errMessage);
    }
  }

  Future reportService({
    required String reportType,
    required String description,
    required double latitude,
    required double longitude,
    required String imageType,
    required File imageFile,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'ReportType': reportType,
        'Description': description,
        'Latitude': latitude,
        'Longitude': longitude,
        'Image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
          contentType: MediaType('image', imageType),
        ),
      });
      var response = post(
        url: "https://pathly.runasp.net/api/Report/Create",
        token:
           ApiKeys.token,
        contentType: "multipart/form-data",
        body: formData,
      );
      log(response.toString());
      return response;
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
}
