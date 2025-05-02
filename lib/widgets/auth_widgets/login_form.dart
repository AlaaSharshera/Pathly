import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/utils/validators.dart';
import 'package:pathly/widgets/auth_widgets/auth_button.dart';
import 'package:pathly/widgets/auth_widgets/auth_center_text.dart';
import 'package:pathly/widgets/auth_widgets/auth_options_row.dart';
import 'package:pathly/widgets/auth_widgets/auth_textfield.dart';
import 'package:pathly/widgets/auth_widgets/auth_textfield_label.dart';
import 'package:pathly/widgets/auth_widgets/forget_pass_row.dart';

class CustomLoginForm extends StatefulWidget {
  const CustomLoginForm({super.key});

  @override
  State<CustomLoginForm> createState() => _CustomLoginFormState();
}

class _CustomLoginFormState extends State<CustomLoginForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? email;

  String? pass;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AuthCenterText(text: "Welcome back!"),
          AuthlabelTextField(text: "E-mail"),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: AuthTextField(
              hintText: "YourName@example.com",
              autovalidateMode: autovalidateMode,
              onSaved: (value) {
                email = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please Enter your E-mail";
                } else if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return "please Enter valid E-mail";
                }
                return null;
              },
            ),
          ),
          AuthlabelTextField(text: "Password"),
          AuthTextField(
            hintText: "••••••••••••••••••",
            autovalidateMode: autovalidateMode,
            obscureText: true,
            onSaved: (value) {
              pass = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please ,Enter Password";
              } else if (validatePassword(value).isNotEmpty) {
                return "pass must have at least ${validatePassword(value)}";
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: ForgetPassRow(onPressed: () {}),
          ),
          AuthButton(
            buttonText: "Sign In",
            onPressed: () async {
              autovalidateMode = AutovalidateMode.onUserInteraction;
              FocusScope.of(context).unfocus();
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              "or",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(color: kBlackColor, fontSize: 20.sp),
              ),
            ),
          ),
          AuthOptionsRow(
            onpressedfacebook: () {},
            onPressedgoogle: () {},
            onPressedApple: () {},
          ),
        ],
      ),
    );
  }
}
