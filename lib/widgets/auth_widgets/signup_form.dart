import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/utils/validators.dart';
import 'package:pathly/widgets/auth_widgets/auth_button.dart';
import 'package:pathly/widgets/auth_widgets/auth_center_text.dart';
import 'package:pathly/widgets/auth_widgets/auth_options_row.dart';
import 'package:pathly/widgets/auth_widgets/auth_textfield.dart';
import 'package:pathly/widgets/auth_widgets/auth_textfield_label.dart';

class CustomSignupForm extends StatefulWidget {
  const CustomSignupForm({super.key});

  @override
  State<CustomSignupForm> createState() => _CustomSignupFormState();
}

class _CustomSignupFormState extends State<CustomSignupForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email;

  String? pass;

  String? userName;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AuthCenterText(text: "Create an account"),
          AuthlabelTextField(text: "User Name"),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: AuthTextField(
              hintText: "alaa123",
              autovalidateMode: autovalidateMode,
              onSaved: (value) {
                userName = value;
              },

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please , Enter user name";
                } else if (validateUserName(value).isNotEmpty) {
                  return "Username must ${validateUserName(value)}";
                }
                return null;
              },
            ),
          ),
          AuthlabelTextField(text: "E-mail"),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: AuthTextField(
              hintText: "YourName@example.com",
              autovalidateMode: autovalidateMode,
              onSaved: (value) {
                email = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please , Enter E-mail";
                } else if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
          ),
          AuthlabelTextField(text: "Password"),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: AuthTextField(
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
          ),
          AuthButton(
            buttonText: "Sign Up",
            onPressed: () async {
              autovalidateMode = AutovalidateMode.onUserInteraction;
              FocusScope.of(context).unfocus();
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "or",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(color: kBlackColor, fontSize: 20),
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
