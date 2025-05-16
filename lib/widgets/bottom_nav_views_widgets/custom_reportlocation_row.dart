
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomReportLocationRow extends StatelessWidget {
  const CustomReportLocationRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
      width: MediaQuery.of(context).size.width*0.6,
      height: 55,
     
      decoration: BoxDecoration(
        color: Color(0xffF4F1F1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        SvgPicture.asset("assets/icons/current_location.svg",width: 21,)
        ,Text("Your auto collected location",style: Styles.styledarkgrey14,),
      ],)
    ),
     Container(
      width: MediaQuery.of(context).size.width*0.28,
      height: 55,
     
      decoration: BoxDecoration(
        color: Color(0xffDEEFF6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        SvgPicture.asset("assets/icons/edit-location.svg",width: 21,color: kPrimaryColor,)
        ,Text("Edit location",style: Styles.stylePrimaryColor12,),
      ],)
    ),
    ],);
  }
}

