import 'package:flutter/material.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomReportTextfield extends StatelessWidget {
  const CustomReportTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: Color(0xffF4F1F1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintText: "You can put any description here",
          hintStyle: Styles.stylegrey16,
          border: InputBorder.none,
          
        ),
      ),
    );
  }
}