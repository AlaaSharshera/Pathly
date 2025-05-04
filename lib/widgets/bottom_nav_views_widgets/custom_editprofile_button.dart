import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomEditprofileButton extends StatelessWidget {
  const CustomEditprofileButton({required this.onPressed, super.key});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Color(0xffE2EBF2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.edit, color: Colors.black, size: 24),
          SizedBox(width: 8),
          Text(
            "Edit profile",
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
