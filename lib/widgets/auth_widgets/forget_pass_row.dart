import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/widgets/general_widgets/custom_switch_icon.dart';

class ForgetPassRow extends StatelessWidget {
  const ForgetPassRow({required this.onPressed, super.key});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            CustomSwitchIcon(),
            Text(
              "remember me",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(color: Color(0xff999999)),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "Forget Password?",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(color: Color(0xff019C4C)),
            ),
          ),
        ),
      ],
    );
  }
}
