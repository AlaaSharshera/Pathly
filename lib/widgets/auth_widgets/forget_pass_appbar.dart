import 'package:flutter/material.dart';
import 'package:pathly/widgets/auth_widgets/appbar_title.dart';

class ForgetPassAppbar extends StatelessWidget {
  const ForgetPassAppbar({this.textWidget, required this.title, super.key});
  final String title;
  final Widget? textWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(child: Image.asset("assets/images/corner.png")),
        Positioned(
          top: 60,
          right: 50,
          left: 0,
          child: customTitleAppBar(title: title),
        ),
        Positioned(bottom: 40, right: 0, left: 20, child: textWidget!),
      ],
    );
  }
}
