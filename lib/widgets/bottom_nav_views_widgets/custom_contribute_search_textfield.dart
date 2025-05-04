import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomContributeSearchTextField extends StatelessWidget {
  const CustomContributeSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 56,
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xffE2EBF2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Where to go?",
          hintStyle: Styles.styledarkgrey18,
          border: InputBorder.none,
          suffixIcon: SvgPicture.asset("images/voice_search.svg", height: 24),
          prefixIcon: SvgPicture.asset("images/search_icon.svg"),
        ),
      ),
    );
  }
}
