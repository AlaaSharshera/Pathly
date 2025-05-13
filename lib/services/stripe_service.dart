import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pathly/models/payment_intent_input_model.dart'
    show PaymentIntentInputModel;
import 'package:pathly/models/payment_intent_model/payment_intent_model.dart';
import 'package:pathly/utils/api.dart';

class StripeService {
  Future<PaymentIntentModel> createPaymentIntent({
    required PaymentIntentInputModel paymentInputModel,
  }) async {
    try {
      var response = await Api().postStripe(
        url: "https://api.stripe.com/v1/payment_intents",
        token:
            "sk_test_51RH2bBIgCCjsMlEk9dexP27OZ0EynEJylBnFYHVcOvbpUQz1Hxq1HXWDhHzqzsyWfweiJj7DGCBzGCermZaGYsEj00Zyvhrptt",
        contentType: Headers.formUrlEncodedContentType,
        body: paymentInputModel.toJson(),
      );
      if (response.statusCode == 200) {
        return PaymentIntentModel.fromJson(response.data);
      } else {
        throw Exception("something went wrong");
      }
    } catch (e) {
      log(e.toString());

      throw Exception(e.toString());
    }
  }

  Future<void> initPaymentSheet({required paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: 'Alaa',
        paymentIntentClientSecret: paymentIntentClientSecret,
        style: ThemeMode.dark,
      ),
    );
  }

  Future displayPayMentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({
    required PaymentIntentInputModel paymentInputModel,
  }) async {
    PaymentIntentModel paymentIntentModel = await createPaymentIntent(
      paymentInputModel: paymentInputModel,
    );
    await initPaymentSheet(
      paymentIntentClientSecret: paymentIntentModel.clientSecret,
    );
    await displayPayMentSheet();
  }
}
