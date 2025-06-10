import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomContributeSearchTextField extends StatelessWidget {
  const CustomContributeSearchTextField({
    required this.color,
    required this.onTap,
    super.key,
  });
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 290,
        height: 45,
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SvgPicture.asset("assets/icons/search_icon.svg"),
            ),
            Text("Where to go?", style: Styles.stylegrey16),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: SvgPicture.asset(
                "assets/icons/voice.svg",
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
