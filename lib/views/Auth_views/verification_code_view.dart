import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:pathly/cubits/forget_pass_cubit/forget_pass_cubit.dart';
import 'package:pathly/cubits/reset_pass_cubit/reset_pass_cubit.dart';
import 'package:pathly/cubits/verify_code_cubit/verify_code_cubit.dart';
import 'package:pathly/cubits/verify_code_cubit/verify_code_states.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/views/Auth_views/set_pass_view.dart';
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
  late Timer _timer;
  int remainingSeconds = 600;
  bool canResend = false;

  Key otpKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    setState(() {
      canResend = false;
      remainingSeconds = 600;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        setState(() {
          canResend = true;
        });
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    final minStr = minutes.toString().padLeft(2, '0');
    final secStr = secs.toString().padLeft(2, '0');
    return "$minStr:$secStr";
  }

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

            code = null;
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage.replaceAll('Exception:', "")),
                backgroundColor: kPrimaryColor,
              ),
            );
          }
        },
        child: Column(
          children: [
            ForgetPassAppbar(
              title: "Verification Code",
              textWidget: textWidget(email: widget.email),
            ),
            OtpTextField(
              numberOfFields: 6,
              fieldWidth: 50,
              fieldHeight: 48,
              borderWidth: 1,
              contentPadding: const EdgeInsets.all(8),
              cursorColor: kPrimaryColor,
              filled: true,
              autoFocus: true,
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
            const SizedBox(height: 20),

            canResend
                ? TextButton(
                  onPressed: () {
                    context.read<ForgetPassCubit>().forgetPassService(
                      email: widget.email,
                    );
                    startCountdown();
                  },
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                : Text(
                  "Resend available in ${formatTime(remainingSeconds)}",
                  style: GoogleFonts.poppins(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),

            const SizedBox(height: 60),
            AuthButton(
              buttonText: "Verify",
              onPressed: () {
                if (code != null && code!.length == 6) {
                  context.read<VerifyCodeCubit>().verifyCode(
                    email: widget.email,
                    code: code!,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter the complete code."),
                      backgroundColor: kPrimaryColor,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget textWidget({required String email}) {
  return Center(
    child: RichText(
      text: TextSpan(
        text: "verification code sent to ",
        style: GoogleFonts.poppins(textStyle: Styles.styleGray12),
        children: [
          TextSpan(
            text: email,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(color: Color(0xff051E3D)),
            ),
          ),
        ],
      ),
    ),
  );
}
