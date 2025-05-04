import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pathly/models/profile_card_model.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomProfileCard extends StatelessWidget {
  const CustomProfileCard({required this.profileCardModel, super.key});
  final ProfileCardModel profileCardModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(profileCardModel.image, width: 24),
      title: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          profileCardModel.title,
          style: Styles.stylePrimaryColorbold18,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(bottom: 16, top: 8),
        child: Row(
          children: [
            Text("Private", style: Styles.stylegrey14),
            SizedBox(width: 20),
            Text("0 places", style: Styles.stylegrey14),
          ],
        ),
      ),
      tileColor: Colors.white,
      trailing: Icon(Icons.more_vert, size: 30),
    );
  }
}
