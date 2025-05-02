import 'package:dio/dio.dart';

class Api {
  Dio dio = Dio();

  Future<Response> postRequest({
    required String url,
    required body,
    String? token,
  }) async {
    var response = await dio.post(
      url,
      data: body,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response;
  }
}
