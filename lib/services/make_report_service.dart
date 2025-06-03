import 'dart:io';
import 'package:image/image.dart' as img;

import 'package:dio/dio.dart';
import 'package:pathly/utils/api.dart';

class MakeReportService {
  Api api = Api();

  Future<File> compressImage(File file) async {
    final image = img.decodeImage(await file.readAsBytes())!;
    final compressedImage = img.copyResize(
      image,
      width: 800,
    ); 
    final tempDir = await Directory.systemTemp.createTemp();
    final compressedFile = File('${tempDir.path}/${file.path.split('/').last}');
    await compressedFile.writeAsBytes(
      img.encodeJpg(compressedImage, quality: 60),
    );
    return compressedFile;
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<dynamic> createReportService({
    required String reportType,
    required String description,
    required double latitude,
    required double longitude,
    required String token,
    required File imageFile,
  }) async {
    final hasConnection = await checkInternetConnection();
    if (!hasConnection) {
      throw Exception('لا يوجد اتصال بالإنترنت');
    }

    try {
      final compressedImage = await compressImage(imageFile);
      FormData formData = FormData.fromMap({
        'ReportType': reportType,
        'Description': description,
        'Latitude': latitude,
        'Longitude': longitude,
        'Image': await MultipartFile.fromFile(
          compressedImage.path,
          filename: compressedImage.path.split('/').last,
        ),
      });
      var response = await api
          .post(
            url: 'https://pathly.runasp.net/api/Report/Create',
            body: formData,
            token: token,
            contentType: "multipart/form-data",
          )
          .timeout(const Duration(seconds: 30));
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
