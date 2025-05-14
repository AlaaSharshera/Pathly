import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';

class RectangleButton extends StatelessWidget {
  const RectangleButton({
    required this.image,
    required this.text,

    required this.onPressed,
    super.key,
  });
  final String image;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(Size(double.infinity, 60)),
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: kPrimaryColor),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "pay with $text",
              style: GoogleFonts.poppins(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Image.asset(image, width: 70),
          ],
        ),
      ),
    );
  }
}
