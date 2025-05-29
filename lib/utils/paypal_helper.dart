import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';
import 'package:pathly/services/create_payment_service.dart';
import 'package:pathly/widgets/payment_widgets/paymentdone_dialog.dart';

class PaymentWithPaypal extends StatelessWidget {
  const PaymentWithPaypal({
    required this.totalPrice,
    required this.planId,
    super.key,
  });
  final String totalPrice;
  final int planId;

  @override
  Widget build(BuildContext context) {
    return PaypalCheckoutView(
      sandboxMode: true,
      clientId:
          "ARpxrThvaXprmnEe-CtdLjIcmL8SztRzUBuncZd7pFfVzU-zhHGKK7ZYnrBu3qVx-EUMmq1XKh3HBvgN",
      secretKey:
          "EOl8PN9i2jGUjcVbI7KyrqS4lclE0AwZg6xZRw5S6lA_Mqp-vHK4_HVUff1ECfDnxdsRjx5OSApHGbYf",
      transactions: [
        {
          "amount": {"total": totalPrice, "currency": "USD"},
        },
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        await CreatePaymentService().createPaymentService(
          palnId: planId,
          token:
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzIiwianRpIjoiOTYyODRkZWItNWFlMS00MTAxLWEwYjktODUxZDUyMWYyMjc3IiwiZW1haWwiOiJhbGFhc0BnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjMiLCJpc0FkbWluIjoiVHJ1ZSIsImV4cCI6MTc0ODI5NDYwNywiaXNzIjoiU2VjdXJlQXBpIiwiYXVkIjoiU2VjdXJlQXBpVXNlciJ9.GASG3PN9w9F-07kME1R7dkdcqIVcL9wEoPjBOMnQHPo",
        );
        Navigator.pop(context);
        Get.dialog(
          CustomDoneDialog(
            text: "Payment Done Successfully!",
            onpressed: () {
              Get.back();
            },
          ),
          barrierColor: Colors.black.withOpacity(0.5),
        );
      },
      onError: (error) {
        log("onError: $error");
        // Navigator.pop(context);
      },
      onCancel: () {
        Navigator.pop(context);
      },
    );
  }
}
