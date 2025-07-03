import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';

class CustomDoneDialog extends StatelessWidget {
  const CustomDoneDialog({
    required this.text,
    required this.onpressed,
    super.key,
  });
  final String text;
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.grey[100],
      backgroundColor: Colors.white,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: kPrimaryColor,
                radius: 28,
                child: Icon(Icons.check, color: Colors.white, size: 40),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  textAlign: TextAlign.center,
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
                ),
                onPressed: onpressed,
                child: Text(
                  "Done",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
