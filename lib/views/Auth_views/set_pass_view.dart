import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/cubits/reset_pass_cubit/reset_pass_cubit.dart';
import 'package:pathly/cubits/reset_pass_cubit/reset_pass_states.dart';
import 'package:pathly/utils/validators.dart';
import 'package:pathly/views/Auth_views/auth_view.dart';
import 'package:pathly/widgets/auth_widgets/auth_button.dart';
import 'package:pathly/widgets/auth_widgets/auth_textfield.dart';
import 'package:pathly/widgets/auth_widgets/auth_textfield_label.dart';
import 'package:pathly/widgets/auth_widgets/forget_pass_appbar.dart';

class SetpassView extends StatefulWidget {
  const SetpassView({required this.email, super.key});
  final String email;

  @override
  State<SetpassView> createState() => _SetpassViewState();
}

class _SetpassViewState extends State<SetpassView> {
  String? pass;

  String? confirmPass;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool obscureText1 = true;
  bool obscureText2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: BlocListener<ResetPassCubit, ResetPassStates>(
        listener: (context, state) {
          if (state is LoadingResetPassState) {
            log("loading");
            Get.dialog(
              Center(child: CircularProgressIndicator(color: kPrimaryColor)),
              barrierDismissible: false,
            );
          } else if (state is SuccessResetPassState) {
            Get.back();
            Get.dialog(customAlertDialog());
            // Get.back();
          } else if (state is FailureResetPassState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ForgetPassAppbar(
                  title: "Set new password",
                  textWidget: const Text(""),
                ),
                AuthlabelTextField(text: "Enter new password"),
                AuthTextField(
                  obscureText: obscureText1,
                  suffixIcon: IconButton(
                    onPressed: () {
                      obscureText1 = !obscureText1;
                      setState(() {});
                    },
                    icon:
                        obscureText1
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                  ),
                  autovalidateMode: autovalidateMode,
                  hintText: "",
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
                const SizedBox(height: 50),
                AuthlabelTextField(text: "Confirm password"),
                AuthTextField(
                  obscureText: obscureText2,
                  suffixIcon: IconButton(
                    onPressed: () {
                      obscureText2 = !obscureText2;
                      setState(() {});
                    },
                    icon:
                        obscureText2
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                  ),
                  autovalidateMode: autovalidateMode,
                  hintText: "",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please ,Enter Password";
                    } else if (validatePassword(value).isNotEmpty) {
                      return "pass must have at least ${validatePassword(value)}";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    confirmPass = value;
                  },
                ),
                const SizedBox(height: 100),
                AuthButton(
                  buttonText: "Reset",
                  onPressed: () async {
                    autovalidateMode = AutovalidateMode.onUserInteraction;
                    setState(() {});
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (pass == confirmPass) {
                        context.read<ResetPassCubit>().resetPass(
                          email: widget.email,
                          password: pass!,
                          confirmPassword: confirmPass!,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Passworsd doesn't match"),
                            backgroundColor: kPrimaryColor,
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget customAlertDialog() {
  return AlertDialog(
    contentPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
    backgroundColor: Colors.white,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/icons/icon_ok.png", height: 45),
        const SizedBox(height: 24),
        Text(
          "Your password changed\nsuccessfully",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 18,
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 32),

        AuthButton(
          buttonText: "Sign in",
          onPressed: () {
            Get.to(() => const AuthView(startWithSignup: false));
          },
        ),
      ],
    ),
  );
}
