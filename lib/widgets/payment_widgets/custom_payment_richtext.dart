import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/models/payment_richtext_model.dart';

Widget customPaymentRichText({
  required PaymentRichtextModel paymentRichtextModel,
}) {
  return RichText(
    text: TextSpan(
      text: paymentRichtextModel.title,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      children: [
        TextSpan(
          text: paymentRichtextModel.subTitle,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Color(0xff5C5454),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}
