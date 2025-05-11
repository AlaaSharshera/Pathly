import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/cubits/get_subscription_plans_cubit/get_subscription_plans_cubit.dart';
import 'package:pathly/models/payment_richtext_model.dart';
import 'package:pathly/views/payment_views/choose_paymentplan_view.dart';
import 'package:pathly/widgets/payment_widgets/custom_payment_appbar.dart';
import 'package:pathly/widgets/payment_widgets/custom_payment_button.dart';
import 'package:pathly/widgets/payment_widgets/custom_payment_richtext.dart';

class TripsDetailsView extends StatelessWidget {
  const TripsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customPaymentAppBar(title: "Start Your free plan today!"),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 24),
                  child: Image.asset(
                    'assets/images/trips_details.png',
                    height: 455,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < texts.length; i++)
                      customPaymentRichText(paymentRichtextModel: texts[i]),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(flex: 3),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "5 free trips, then\n",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color(0xff5C5454),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              children: [
                TextSpan(
                  text: "5\$ ",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color(0xff1E1E1E),
                      fontSize: 14,
                    ),
                  ),
                ),
                TextSpan(
                  text: "per month or ",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color(0xff5C5454),
                      fontSize: 14,
                    ),
                  ),
                ),
                TextSpan(
                  text: "50\$ ",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color(0xff1E1E1E),
                      fontSize: 14,
                    ),
                  ),
                ),
                TextSpan(
                  text: "per year",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color(0xff5C5454),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CustomPaymentButton(
              buttonText: "Continue",
              onPressed: () async {
                Get.to(
                  () => BlocProvider<GetSubscriptionPlansCubit>(
                    create:
                        (context) => GetSubscriptionPlansCubit()..getPlans(),
                    child: const ChoosePaymentPlanView(),
                  ),
                );
              },
            ),
          ),
          Text(
            "Cancel anytime before your next billing cycle",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 12,
                color: Color(0xff5C5454),
              ),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
