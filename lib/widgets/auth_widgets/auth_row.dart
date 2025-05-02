import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthRow extends StatelessWidget {
  const AuthRow({
    required this.buttonText,
    required this.onPressed,
    required this.text,
    super.key,
  });
  final String text;
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(color: Color(0xff019C4C)),
            ),
          ),
        ),
      ],
    );
  }
}
