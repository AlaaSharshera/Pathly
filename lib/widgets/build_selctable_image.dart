import 'package:flutter/material.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/utils/textstyles.dart';

class BuildSelctableImage extends StatelessWidget {
  const BuildSelctableImage({
    required this.imagePath,
    required this.text,
    required this.isSelected,
    required this.onTap,
    super.key,
  });
  final VoidCallback onTap;
  final bool isSelected;
  final String imagePath;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            margin: EdgeInsets.only(bottom: 6),
            duration: Duration(milliseconds: 400),
            decoration: BoxDecoration(
              border:
                  isSelected
                      ? Border.all(color: kPrimaryColor, width: 3)
                      : null,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.fill,
              height: 85,
              width: 130,
            ),
          ),
          Text(text, style: Styles.styledarkblack16bold),
        ],
      ),
    );
  }
}
