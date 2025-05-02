import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';

class AuthlabelTextField extends StatelessWidget {
  const AuthlabelTextField({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 20, top: 16),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: kBlackColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
