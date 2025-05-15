import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pathly/models/nearby_places_model/nearby_places_model.dart';
import 'package:pathly/utils/textstyles.dart';

class NearbyPlacesContainer extends StatelessWidget {
  const NearbyPlacesContainer({required this.isActive,required this.nearbyPlacesModel,super.key});

 final bool isActive;
final NearbyPlacesModel nearbyPlacesModel;
  @override
  Widget build(BuildContext context) {
    return Container(
     
      padding: EdgeInsets.all(24),
      color: isActive?Color(0xffF4F1F1):Colors.white,
    width: double.infinity,child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
Text(nearbyPlacesModel.name!,style: Styles.styledarkblack16bold,overflow: TextOverflow.visible,),
 SizedBox(height: 10,),
Text(nearbyPlacesModel.address!,style: Styles.styleblack16,overflow: TextOverflow.visible,),
 SizedBox(height: 10,),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(nearbyPlacesModel.rating.toString(),style: Styles.styledarkblack16bold),
    //SizedBox(width: 10,),
   RatingBarIndicator(
  rating: nearbyPlacesModel.rating!, 
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