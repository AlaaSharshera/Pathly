import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_settings_textbutton.dart';
import 'package:pathly/widgets/general_widgets/custom_switch_icon.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                CustomSettingsTextButton(
                  onPressed: () {},
                  text: "App language",
                ),
                CustomSettingsTextButton(
                  onPressed: () {},
                  text: "Offline map settings",
                ),
                CustomSettingsTextButton(
                  onPressed: () {},
                  text: "Manage subscription",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomSettingsTextButton(
                      onPressed: () {},
                      text: "Wi-Fi only",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CustomSwitchIcon(),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomSettingsTextButton(
                      onPressed: () {},
                      text: "Theme",
                      bottomPadding: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 16),
                      child: Text(
                        textAlign: TextAlign.start,
                        "Always in light theme",
                        style: GoogleFonts.poppins(
                          height: 1,
                          color: Color(0xff999999),

                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomSettingsTextButton(
                  onPressed: () {},
                  text: "Saved trips settings",
                ),
                CustomSettingsTextButton(
                  onPressed: () {},
                  text: "Location settings",
                ),
                CustomSettingsTextButton(
                  onPressed: () {},
                  text: "Accessibility settings",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSettingsTextButton(
                          bottomPadding: 0,
                          onPressed: () {},
                          text: "Map History",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            bottom: 16,
                          ),
                          child: SvgPicture.asset("assets/icons/warning.svg"),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CustomSwitchIcon(),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomSettingsTextButton(
                      onPressed: () {},
                      text: "Start map in satellite view",
                      bottomPadding: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 16),
                      child: Text(
                        textAlign: TextAlign.start,
                        "Uses more cellular data",
                        style: GoogleFonts.poppins(
                          height: 1,
                          color: Color(0xff999999),

                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomSettingsTextButton(
                  onPressed: () {},
                  text: "Your Vehicles",
                ),
                CustomSettingsTextButton(onPressed: () {}, text: "Chat"),
                CustomSettingsTextButton(onPressed: () {}, text: "Navigation"),
                CustomSettingsTextButton(
                  onPressed: () {},
                  text: "Manage your prefernces",
                ),
                CustomSettingsTextButton(
                  onPressed: () {},
                  text: "Manage your areas",
                ),
                CustomSettingsTextButton(
                  onPressed: () {},
                  text: "Offline map settings",
                ),
                CustomSettingsTextButton(
                  onPressed: () {},
                  text: "About, terms & Privacy",
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      textAlign: TextAlign.start,
                      "Sign out",
                      style: Styles.styleredbold18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
