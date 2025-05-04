import 'package:flutter/material.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_editprofile_button.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_profile_listview.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Image.asset("images/profile.png"),
                  SizedBox(width: 16),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Alaa Sharshera",
                        style: Styles.stylePrimaryColorbold18,
                      ),
                      SizedBox(height: 12),
                      CustomEditprofileButton(onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("0", style: Styles.stylePrimaryColorbold18),
                    Text("Contributions", style: Styles.stylegrey16),
                  ],
                ),
                Column(
                  children: [
                    Text("0", style: Styles.stylePrimaryColorbold18),
                    Text("Points", style: Styles.stylegrey16),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "☕🏃‍♀️ عيط واشرب قهوة وكمل سعي ",
                      hintStyle: Styles.styleblack16,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xff999999)),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xff999999)),
                      ),
                      enabled: false,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xff999999)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    left: 20,
                    child: Text("Bio", style: Styles.stylePrimaryColorbold18),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 16, bottom: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your Lists",
                  style: Styles.stylePrimaryColorbold18,
                ),
              ),
            ),
            Expanded(child: SingleChildScrollView(child: CustomProfileList())),
          ],
        ),
      ),
    );
  }
}
