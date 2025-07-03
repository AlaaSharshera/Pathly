import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pathly/constant.dart';

class DirectionButton extends StatelessWidget {
  const DirectionButton({required this.onTap, super.key});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SvgPicture.asset("assets/icons/directions.svg"),
      ),
    );
  }
}
