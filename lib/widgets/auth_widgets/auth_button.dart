import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.buttonText,
    required this.onPressed,
    super.key,
  });
  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
