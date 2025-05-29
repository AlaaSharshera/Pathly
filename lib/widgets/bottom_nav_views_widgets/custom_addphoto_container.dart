import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomAddphotoContainer extends StatelessWidget {
  const CustomAddphotoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 172,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xffF4F1F1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/icons/addphoto.svg", width: 40),
          SizedBox(height: 10),
          Text("Add photo", style: Styles.stylegrey16),
        ],
      ),
    );
  }
}
