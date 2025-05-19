import 'package:flutter/material.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomReportTextfield extends StatelessWidget {
  const CustomReportTextfield({required this.onSaved,required this.validator,required this.autovalidateMode,super.key});
final String? Function(String?)? validator;
final void Function(String?)? onSaved;
final AutovalidateMode? autovalidateMode;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
     //padding: EdgeInsets.all(16),
      alignment: Alignment.center,
     // height: 55,
      decoration: BoxDecoration(
        color: Color(0xffF4F1F1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        validator:validator,
        onSaved:onSaved,
        maxLines: 2,
        cursorColor: kPrimaryColor,
        autovalidateMode: autovalidateMode,
        decoration: InputDecoration(
          
         contentPadding: EdgeInsets.all( 8),
          hintText: "You can put any description here",
          hintStyle: Styles.stylegrey16,
          border: InputBorder.none,
          
        ),
      ),
    );
  }
}