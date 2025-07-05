import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/utils/textstyles.dart';

class WorkHomeRow extends StatelessWidget {
  const WorkHomeRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: Row(
        children: [
          const CustomContainer(
            image: "assets/icons/home.svg",
            location: "31.114541212",
            placeName: "Home",
          ),
          const VerticalDivider(indent: 16, width: 1),
          const CustomContainer(
            image: "assets/icons/work.svg",
            placeName: "Work",
            location: "31.114541212",
          ),
          const VerticalDivider(indent: 16, width: 1),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/icons/menu-dots.svg",
                ),
              ),
              Text("More", style: Styles.stylePrimaryColorbold16),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    required this.image,
    required this.placeName,
    required this.location,
    super.key,
  });
  final String image;
  final String placeName;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 76,
      width: 130,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xffE2EBF2),
            child: SvgPicture.asset(image, width: 16),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(placeName, style: Styles.stylePrimaryColorbold16),
              Text(
                location,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xff1E1E1E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
