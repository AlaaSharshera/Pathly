import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomContributeSearchTextField extends StatelessWidget {
  const CustomContributeSearchTextField({required this.color, super.key});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Where to go?",
          hintStyle: Styles.stylegrey16,
          border: InputBorder.none,
          suffixIcon: SvgPicture.asset("assets/icons/voice_search.svg"),
          prefixIcon: SvgPicture.asset("assets/icons/search_icon.svg"),
        ),
      ),
    );
  }
}
