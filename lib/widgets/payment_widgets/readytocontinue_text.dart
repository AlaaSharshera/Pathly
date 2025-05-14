import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReadytocontinueText extends StatelessWidget {
  const ReadytocontinueText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Ready to continue?",
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          height: 3,
          color: Color(0xff5C5454),
        ),
      ),
    );
  }
}
