import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/widgets/auth_widgets/auth_button.dart';
import 'package:pathly/widgets/auth_widgets/auth_textfield.dart';
import 'package:pathly/widgets/auth_widgets/auth_textfield_label.dart';
import 'package:pathly/widgets/auth_widgets/forget_pass_appbar.dart';

class ForgetpassView extends StatefulWidget {
  const ForgetpassView({super.key});

  @override
  State<ForgetpassView> createState() => _ForgetpassViewState();
}

class _ForgetpassViewState extends State<ForgetpassView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ForgetPassAppbar(
                title: "Forgot Your password?",
                textWidget: Text(
                  "Write your email address to receive a confirmation\ncode to set a new password",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(textStyle: Styles.styleGray12),
                ),
              ),
              Stack(
                children: [
                  Image.asset("assets/images/location-logo.png"),
                  Column(
                    children: [
                      AuthlabelTextField(text: "E-mail"),
                      AuthTextField(
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
                        hintText: "YourName@example.com",
                      ),
                      const SizedBox(height: 100),
                      AuthButton(
                        buttonText: "Send E-mail",
                        onPressed: () async {
                          autovalidateMode = AutovalidateMode.onUserInteraction;
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
