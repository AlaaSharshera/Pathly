import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pathly/utils/textstyles.dart';

class RqiWidget extends StatelessWidget {
  const RqiWidget({required this.alignment,super.key});
final AlignmentGeometry alignment;
  @override
  Widget build(BuildContext context) {
    return Padding(
   padding: const EdgeInsets.only(right:2.0),
   child: Align(alignment: alignment,
    child: SizedBox(
      height: 280,
      child: Row(mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 250,
            child: Stack(children: [
              SvgPicture.asset("assets/icons/rqi.svg",height: 250,width: 18,),
              Positioned(
                right: 0.5,
                left: 0.5,
                top: 5,
                bottom: 5,
                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
                  children: [
                   Text("0",style: Styles.stylePrimaryColor10,),
                            Text("4",style: Styles.stylePrimaryColor10,),
                            Text("6",style: Styles.stylePrimaryColor10,),
                            Text("8",style: Styles.stylePrimaryColor10,),
                            Text("10",style: Styles.stylePrimaryColor10,),
                ],),
              )
            ],),
          ),
        Column(
        
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Text("very Bad",style: Styles.stylewhite10,),
          Text("Hole",style: Styles.stylewhite10,),
          Text("Bumb",style: Styles.stylewhite10,),
          Text("Perfect",style: Styles.stylewhite10,),
        ],)
        ],),
    )),
 );
  }
}