import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pathly/utils/api.dart';

class CreatePaymentService {
  Future<dynamic> createPaymentService({
    required String token,
    required int palnId,
  }) async {
    FormData formData = FormData.fromMap({'subscriptionPlanId': palnId});
    var response = await Api().postRequest(
      url: "https://pathly.runasp.net/api/Payment/create",
      token: token,
      body: formData,
    );
    log("succes $palnId");
    return response;
  }
}
