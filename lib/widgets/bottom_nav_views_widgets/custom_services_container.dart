import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomServicesContainer extends StatelessWidget {
  const CustomServicesContainer({
    required this.image,
    required this.placeName,
    super.key,
  });
  final String image;
  final String placeName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      width: 181,
      decoration: BoxDecoration(
        color: Color(0xffE2EBF2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(image),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(placeName, style: Styles.stylePrimaryColorbold18),
              Text(
                "Edit the address",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Color(0xff1E1E1E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
