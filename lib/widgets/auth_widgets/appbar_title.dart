import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/utils/textstyles.dart';

Widget customTitleAppBar({required String title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios),
        color: Colors.white,
      ),
      Text(
        title,
        style: GoogleFonts.poppins(textStyle: Styles.styleWhiteBold16),
      ),
    ],
  );
}
