import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/models/subscribtion_plans_model.dart';

class CustomPlanContainer extends StatelessWidget {
  const CustomPlanContainer({
    required this.subscriptionPlansModel,
    required this.text,
    required this.isSelected,
    super.key,
  });
  final SubscriptionPlansModel subscriptionPlansModel;
  final String text;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      padding: EdgeInsets.all(2),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient:
            isSelected
                ? LinearGradient(
                  colors: [
                    Color(0xff1F537F),
                    Color(0xff327DBC),
                    Color(0xff1F537F),
                    Color(0xff173956),
                    Color(0xff327DBC),
                  ],
                )
                : null,
      ),

      child: Container(
        width: double.infinity,
        height: 170,
        alignment: Alignment.topLeft,

        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xffEBEBF0),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Center(
              child: Text(
                subscriptionPlansModel.name!,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color(0xff1E1E1E),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                " ${subscriptionPlansModel.price!.toInt()}\$ $text",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            Text(
              subscriptionPlansModel.description.toString(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  height: 1.5,
                  color: Color(0xff1E1E1E),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
