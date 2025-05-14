import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';

class CustomPaymentButton extends StatelessWidget {
  const CustomPaymentButton({
    required this.buttonText,
    required this.onPressed,
    super.key,
  });
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        fixedSize: const WidgetStatePropertyAll(Size(283, 56)),
        backgroundColor: const WidgetStatePropertyAll(kPrimaryColor),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
      ),
      child: Text(buttonText, style: GoogleFonts.poppins()),
    );
  }
}
