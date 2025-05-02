import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/widgets/auth_widgets/auth_button.dart';
import 'package:pathly/widgets/auth_widgets/forget_pass_appbar.dart';

class VerificationCodeView extends StatelessWidget {
  const VerificationCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Column(
        children: [
          ForgetPassAppbar(
            title: "Verification Code",
            textWidget: textWidget(),
          ),
          OtpTextField(
            numberOfFields: 6,
            fieldWidth: 50,
            fieldHeight: 48,
            borderWidth: 1,
            contentPadding: const EdgeInsets.all(8),
            cursorColor: kPrimaryColor,
            filled: true,
            textStyle: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            borderRadius: BorderRadius.circular(8),

            fillColor: const Color(0xffE8EAF0),
            focusedBorderColor: kPrimaryColor,

            showFieldAsBox: true,

            onCodeChanged: (String code) {},

            onSubmit: (String verificationCode) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Verification Code"),
                    content: Text('Code entered is $verificationCode'),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 100),
          AuthButton(buttonText: "Verify", onPressed: () {}),
        ],
      ),
    );
  }
}

Widget textWidget() {
  return Center(
    child: RichText(
      text: TextSpan(
        text: "verification code sent to",
        style: GoogleFonts.poppins(textStyle: Styles.styleGray12),
        children: [
          TextSpan(
            text: " alaa@gmail.com",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(color: Color(0xff051E3D)),
            ),
          ),
        ],
      ),
    ),
  );
}
