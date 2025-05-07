import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/models/custom_contribute_model.dart';

class CustomContributeServiceCoulmn extends StatelessWidget {
  const CustomContributeServiceCoulmn({
    required this.contributeModel,
    super.key,
  });
  final CustomContributeModel contributeModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(contributeModel.image),
        Text(
          contributeModel.text,
          style: GoogleFonts.poppins(color: kPrimaryColor, fontSize: 11),
        ),
      ],
    );
  }
}
