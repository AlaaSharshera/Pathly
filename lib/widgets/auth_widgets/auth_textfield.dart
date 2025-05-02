import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.controller,
    this.focusNode,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.onChanged,
    required this.onSaved,
    required this.textInputAction,
    this.suffixIcon,
    required this.validator,
    super.key,
  });
  final String hintText;
  final bool obscureText;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final Icon? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        onSaved: onSaved,
        onChanged: onChanged,
        obscureText: obscureText,
        validator: validator,
        obscuringCharacter: '•',
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        focusNode: focusNode,
        cursorHeight: 16,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            textStyle: const TextStyle(fontSize: 14, color: Color(0xffD1D1D6)),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.only(top: 12),
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
