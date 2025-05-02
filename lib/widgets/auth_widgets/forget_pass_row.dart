import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/views/forget_pass_view.dart';
import 'package:pathly/widgets/general_widgets/custom_switch_icon.dart';

class ForgetPassRow extends StatelessWidget {
  const ForgetPassRow({super.key});

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
          onPressed: () {
            Get.to(() => ForgetpassView());
          },
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
