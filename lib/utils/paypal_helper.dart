import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/cubits/botton_navbar_cubit/bottom_navbar_cubit.dart';
import 'package:pathly/services/create_payment_service.dart';
import 'package:pathly/views/bottom_nav_views/bottom_navbar.dart';
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
      loadingIndicator: CircularProgressIndicator(color: kPrimaryColor,),
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
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxNyIsImp0aSI6IjBjYWU1NzgwLWVkZDUtNGY0OS04NDI1LWUyNmM1YWE1ZjBmOSIsImVtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiMTciLCJpc0FkbWluIjoiRmFsc2UiLCJleHAiOjE3NTIxNDU0ODgsImlzcyI6IlNlY3VyZUFwaSIsImF1ZCI6IlNlY3VyZUFwaVVzZXIifQ.b4lyjBAojwpBblYCrmc7Ipxql1lq-5C0aymLz4oJkwU",
        );
        Navigator.pop(context);
        Get.dialog(
          CustomDoneDialog(
            text: "Payment Done Successfully!",
            onpressed: () {
              Get.offAll(
                () => BlocProvider<BottomNavbarCubit>(
                  create: (context) => BottomNavbarCubit(),
                  child: BottomNavbar(),
                ),
              );
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
