import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomLocationCard extends StatelessWidget {
  const CustomLocationCard({required this.distinationName,super.key});
 final String distinationName;
  @override
  Widget build(BuildContext context) {
    return  Container(
            margin: EdgeInsets.all(32),
            padding:EdgeInsets.all(8) ,
            width: MediaQuery.of(context).size.width,
            height: 92,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(16),border:Border.all(color: Color(0xff999999),width: 1)),
child: Row(children: [
  Image.asset('assets/icons/origin_to_distination.png'),
  Expanded(
   
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text("Your location",style: Styles.stylePrimaryColorbold18),
      Divider(color: Color(0xff999999),thickness: 1,height: 10,),
      Text(distinationName,style: Styles.styledarkgrey18,textAlign: TextAlign.start,)
    ],),
  ),
  SvgPicture.asset('assets/icons/arrow_back.svg',height: 35,)

],),
          );
  }
}