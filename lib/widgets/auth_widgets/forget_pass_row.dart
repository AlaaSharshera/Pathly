import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            SizedBox(width: 8.w),
            Text(
              "remember me",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(color: Color(0xff999999), fontSize: 12.sp),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "Forget Password?",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(color: Color(0xff019C4C), fontSize: 12.sp),
            ),
          ),
        ),
      ],
    );
  }
}
