import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/cubits/botton_navbar_cubit/bottom_navbar_cubit.dart';
import 'package:pathly/cubits/signup_cubit/signup_cubit.dart';
import 'package:pathly/cubits/signup_cubit/signup_states.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/utils/validators.dart';
import 'package:pathly/views/bottom_nav_views/bottom_navbar.dart';
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
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is LoadingSignupState) {
          Get.dialog(
            Center(child: CircularProgressIndicator(color: kPrimaryColor)),
            barrierDismissible: false,
          );
        } else if (state is SuccessSignupState) {
          Get.back();
          log(state.authResponseModel.token);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Register Successfully"),
              backgroundColor: kPrimaryColor,
            ),
          );
          Get.offAll(
            BlocProvider<BottomNavbarCubit>(
              create: (context) => BottomNavbarCubit(),
              child: BottomNavbar(),
            ),
          );
        } else if (state is FailureSignupState) {
          Get.back();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errMessage.replaceAll("Exception:", ""),
                style: Styles.stylePrimaryColor12,
              ),
              backgroundColor: Colors.white,
            ),
          );
        }
      },
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
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
                  obscureText: obscureText,
                  suffixIcon: IconButton(
                    onPressed: () {
                      obscureText = !obscureText;
                      setState(() {});
                    },
                    icon:
                        obscureText
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                  ),
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
                    try {
                      context.read<SignupCubit>().signService(
                        username: userName!,
                        email: email!,
                        password: pass!,
                      );
                      Get.offAll(() => BottomNavbar);
                    } catch (e) {
                      log("Cubit failed");
                    }
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "or",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: kBlackColor,
                      fontSize: 20,
                    ),
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
        ),
      ),
    );
  }
}
