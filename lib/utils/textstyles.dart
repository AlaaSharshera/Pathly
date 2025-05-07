import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';

abstract class Styles {
  static TextStyle styleGray12 = GoogleFonts.poppins(
    color: Color(0xff989393),
    fontSize: 12,
  );

  static TextStyle styleWhiteBold16 = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static TextStyle stylePrimaryColorbold18 = GoogleFonts.poppins(
    color: kPrimaryColor,
    fontSize: 18,
    letterSpacing: 0.5,

    height: 1.33,
    fontWeight: FontWeight.w500,
  );
  static TextStyle stylePrimaryColorbold16 = GoogleFonts.poppins(
    color: kPrimaryColor,
    fontSize: 16,
    letterSpacing: 0.5,

    height: 1.33,
    fontWeight: FontWeight.w500,
  );
  static TextStyle styleredbold18 = GoogleFonts.poppins(
    color: Colors.red,
    fontSize: 18,
    letterSpacing: 0.5,

    height: 1.33,
    fontWeight: FontWeight.w500,
  );

  static TextStyle stylegrey14 = GoogleFonts.poppins(
    color: Color(0xffD1D1D6),
    fontSize: 14,
  );
  static TextStyle stylegrey16 = GoogleFonts.poppins(
    color: Color(0xff999999),
    fontSize: 16,
  );
  static TextStyle styledarkgrey16bold = GoogleFonts.poppins(
    color: Color(0xff5C5454),
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle styledarkgrey18bold = GoogleFonts.poppins(
    color: Color(0xff5C5454),
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static TextStyle styledarkgrey18 = GoogleFonts.poppins(
    color: Color(0xff5C5454),
    fontSize: 18,
  );
  static TextStyle styledarkgrey16 = GoogleFonts.poppins(
    color: Color(0xff5C5454),
    fontSize: 16,
  );
  static TextStyle styleblack16 = GoogleFonts.poppins(
    color: Color(0xff1E1E1E),
    fontSize: 16,
  );
}
