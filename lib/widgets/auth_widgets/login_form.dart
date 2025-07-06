import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/cubits/botton_navbar_cubit/bottom_navbar_cubit.dart';
import 'package:pathly/cubits/login_cubit/login_cubit.dart';
import 'package:pathly/cubits/login_cubit/login_states.dart';
import 'package:pathly/utils/validators.dart';
import 'package:pathly/views/bottom_nav_views/bottom_navbar.dart';
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
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocListener<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoadingLoginState) {
            log("loading");
            Get.dialog(
              Center(child: CircularProgressIndicator(color: kPrimaryColor)),
              barrierDismissible: false,
            );
          } 
          else if (state is SuccessLoginState) {
  Get.back();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "Login Successfully",
        style: GoogleFonts.poppins(
          color: kPrimaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Colors.white,
    ),
  );
  Get.offAll(
    () => BlocProvider<BottomNavbarCubit>(
      create: (context) => BottomNavbarCubit(),
      child: BottomNavbar(),
    ),
  );
}

          else if (state is FailureLoginState) {
            Get.back();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(
               backgroundColor: Colors.white,content: Text("Email or Password is incorrect!",style: GoogleFonts.poppins(
          color: kPrimaryColor,
          fontWeight: FontWeight.w500,
        ),)));
          }
        },
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: ForgetPassRow(),
            ),
            AuthButton(
              buttonText: "Sign In",
              onPressed: () async {
                autovalidateMode = AutovalidateMode.onUserInteraction;
                FocusScope.of(context).unfocus();
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  try {
                    context.read<LoginCubit>().loginService(
                      email: email!,
                      password: pass!,
                    );
              
                  } catch (e) {
                    throw Exception("Cubit failed");
                  }
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
      ),
    );
  }
}
