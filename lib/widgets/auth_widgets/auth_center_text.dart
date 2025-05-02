import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthCenterText extends StatelessWidget {
  const AuthCenterText({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(text,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xff051E3D),
            ),
          )),
    );
  }
}
