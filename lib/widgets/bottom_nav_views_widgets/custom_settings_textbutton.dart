import 'package:flutter/material.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomSettingsTextButton extends StatelessWidget {
  const CustomSettingsTextButton({
    required this.onPressed,
    required this.text,
    this.bottomPadding = 16,
    super.key,
  });
  final String text;
  final VoidCallback onPressed;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          textAlign: TextAlign.start,
          text,
          style: Styles.stylePrimaryColorbold18,
        ),
      ),
    );
  }
}
