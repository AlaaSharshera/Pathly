import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    this.controller,
    this.focusNode,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.onSaved,
    this.textInputAction,
    this.suffixIcon,
    required this.validator,
    required this.autovalidateMode,
    super.key,
  });
  final String hintText;
  final bool obscureText;
  final void Function(String?)? onSaved;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TextFormField(
        onSaved: onSaved,
        cursorColor: kPrimaryColor,
        obscureText: obscureText,
        validator: validator,
        obscuringCharacter: '•',
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        focusNode: focusNode,
        autovalidateMode: autovalidateMode,
        cursorHeight: 16.h,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 14.sp, color: Color(0xffD1D1D6)),
          ),
          isDense: true,
          contentPadding: EdgeInsets.only(top: 12.h),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlackColor),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
