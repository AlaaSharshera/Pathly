import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class BuildCard extends StatelessWidget {
  const BuildCard({ 
  required this.icon,
   required this.title,
    required this.onTap,super.key});
final String icon;

final VoidCallback onTap;
final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 50,
      child: ListTile(
        leading: SvgPicture.asset(icon),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}


 