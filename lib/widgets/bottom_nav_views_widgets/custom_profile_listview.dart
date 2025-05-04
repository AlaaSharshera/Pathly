import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/models/profile_card_model.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_profile_card.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_profile_divider.dart';

class CustomProfileList extends StatelessWidget {
  const CustomProfileList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Column(
            children: List.generate(cards.length, (index) {
              return Column(
                children: [
                  CustomProfileCard(profileCardModel: cards[index]),
                  CustomProfileDivider(),
                ],
              );
            }),
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 197,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),

                decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Remember where you\nhave been",
                        style: Styles.stylePrimaryColorbold18,
                      ),
                      Text(
                        "see your past places & routes\non a private Timeline",
                        style: GoogleFonts.poppins(
                          color: Color(0xff1E1E1E),
                          fontSize: 14,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            kPrimaryColor,
                          ),
                        ),
                        child: Text(
                          "Turn On Timeline",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                right: 20,
                child: Image.asset("images/profile-container-image.png"),
              ),
              Positioned(
                right: 20,
                top: 10,
                child: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
