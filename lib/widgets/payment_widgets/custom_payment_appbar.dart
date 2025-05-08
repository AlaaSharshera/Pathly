import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';

PreferredSizeWidget customPaymentAppBar({required String title}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(Icons.arrow_back_ios),
      color: const Color(0xff1E1E1E),

      iconSize: (20),
    ),
    title: Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 20,
          color: kPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
