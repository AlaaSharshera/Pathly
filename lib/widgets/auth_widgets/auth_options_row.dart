import 'package:flutter/material.dart';

class AuthOptionsRow extends StatelessWidget {
  const AuthOptionsRow({
    required this.onPressedApple,
    required this.onPressedgoogle,
    required this.onpressedfacebook,
    super.key,
  });
  final VoidCallback onpressedfacebook;
  final VoidCallback onPressedgoogle;
  final VoidCallback onPressedApple;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        customImage(
          onpressed: onpressedfacebook,
          imagePath: 'assets/images/facebook_icon.png',
        ),
        customImage(
          onpressed: onPressedgoogle,
          imagePath: 'assets/images/google_icon.png',
        ),
        customImage(
          onpressed: onPressedApple,
          imagePath: 'assets/images/apple_icon.png',
        ),
      ],
    );
  }
}

Widget customImage({
  required VoidCallback onpressed,
  required String imagePath,
}) {
  return InkWell(onTap: onpressed, child: Image.asset(imagePath, height: 22));
}
