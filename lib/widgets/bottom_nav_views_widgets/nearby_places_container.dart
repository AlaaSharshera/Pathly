import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pathly/utils/textstyles.dart';

class NearbyPlacesContainer extends StatelessWidget {
  const NearbyPlacesContainer({required this.isActive,super.key});

 final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
     
      padding: EdgeInsets.all(12),
      color: isActive?Color(0xffF4F1F1):Colors.white,
    width: double.infinity,child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
Text("National Bank Of Egypt",style: Styles.styledarkblack16bold,overflow: TextOverflow.visible,),
 SizedBox(height: 10,),
Text("CMQG+WX7, مدينة دمياط الجديدة, الظهير الصحراوى لمحافظة دمياط",style: Styles.styleblack16,overflow: TextOverflow.visible,),
 SizedBox(height: 10,),
Row(
  children: [
    Text("5.2",style: Styles.styledarkblack16bold),
    SizedBox(width: 10,),
   RatingBarIndicator(
  rating: 3.7, 
  itemBuilder: (context, index) => Icon(
    Icons.star,
    color: Colors.amber,
  ),
  itemCount: 5,
  itemSize: 20.0,
  unratedColor: Color(0xffDFDFE1),
  direction: Axis.horizontal,
)

  ],
)


    ],),);
  }
}