import 'package:dio/dio.dart';
import 'package:pathly/models/full_routes_data_model/full_routes_data_model.dart';
import 'package:pathly/models/location_info/location_info.dart';
import 'package:pathly/models/route_modifiers.dart';
import 'package:pathly/utils/api_keys.dart';

class FetchRoutesServiceClass {
  final Dio dio = Dio();
  Future<FullRoutesDataModel> fetchRoutesService({
    required LocationInfoModel origin,
    required LocationInfoModel distination,
    RouteModifiers? routeModifiers,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': ApiKeys.routesApiKey,
      'X-Goog-FieldMask':
          'routes.legs.distanceMeters,routes.legs.steps.navigationInstruction,routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline,routes.routeLabels,routes.legs.steps.distanceMeters,routes.legs.steps.staticDuration',
    };
    Map<String, dynamic> body = {
      "origin": origin.toJson(),
      "destination": distination.toJson(),
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "computeAlternativeRoutes": true,
      "routeModifiers":
          routeModifiers != null
              ? routeModifiers.toJson()
              : RouteModifiers().toJson(),
      "languageCode": "en-US",
      "units": "METRIC",
    };
    try {
      var response = await dio.post(
        "https://routes.googleapis.com/directions/v2:computeRoutes",
        options: Options(headers: headers),
        data: body,
      );
      if (response.statusCode == 200) {
     
        return FullRoutesDataModel.fromJson(response.data);
      } else {
        throw Exception("No Routes Found");
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
}

