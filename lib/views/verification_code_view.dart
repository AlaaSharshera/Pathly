import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:pathly/cubits/reset_pass_cubit/reset_pass_cubit.dart';
import 'package:pathly/cubits/verify_code_cubit/verify_code_cubit.dart';
import 'package:pathly/cubits/verify_code_cubit/verify_code_states.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/views/set_pass_view.dart';
import 'package:pathly/widgets/auth_widgets/auth_button.dart';
import 'package:pathly/widgets/auth_widgets/forget_pass_appbar.dart';

class VerificationCodeView extends StatefulWidget {
  const VerificationCodeView({required this.email, super.key});
  final String email;

  @override
  State<VerificationCodeView> createState() => _VerificationCodeViewState();
}

class _VerificationCodeViewState extends State<VerificationCodeView> {
  String? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: BlocListener<VerifyCodeCubit, VerifyCodeStates>(
        listener: (context, state) {
          if (state is LoadingVerifyCodeState) {
            log("loading");
            Get.dialog(
              Center(child: CircularProgressIndicator(color: kPrimaryColor)),
              barrierDismissible: false,
            );
          } else if (state is SuccessVerifyCodeState) {
            Get.back();
            Get.to(
              () => BlocProvider<ResetPassCubit>(
                create: (context) => ResetPassCubit(),
                child: SetpassView(email: widget.email),
              ),
            );
          } else if (state is FailureVerifyCodeState) {
            Get.back();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        child: Column(
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
                code = verificationCode;
                setState(() {});
              },
            ),
            const SizedBox(height: 100),
            AuthButton(
              buttonText: "Verify",
              onPressed: () {
                context.read<VerifyCodeCubit>().verifyCode(
                  email: widget.email,
                  code: code!,
                );
              },
            ),
          ],
        ),
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
