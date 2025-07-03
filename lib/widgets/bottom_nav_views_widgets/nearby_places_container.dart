import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/models/nearby_places_model/nearby_places_model.dart';
import 'package:pathly/utils/textstyles.dart';

class NearbyPlacesContainer extends StatelessWidget {
  const NearbyPlacesContainer({
    required this.isActive,
    required this.nearbyPlacesModel,
    super.key,
  });

  final bool isActive;
  final NearbyPlacesModel nearbyPlacesModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      color: isActive ? Color(0xffF4F1F1) : Colors.white,
      width: double.infinity,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  nearbyPlacesModel.name!,
                  style: Styles.stylePrimaryColorbold18,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  nearbyPlacesModel.address!,
                  style: Styles.styleblack16,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              //SizedBox(height: 10),
              SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    nearbyPlacesModel.rating.toString(),
                    style: Styles.styledarkblack16bold,
                  ),
                  SizedBox(width: 10),
                  RatingBarIndicator(
                    rating: nearbyPlacesModel.rating!,
                    itemBuilder:
                        (context, index) =>
                            Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 20.0,
                    unratedColor: Color(0xffDFDFE1),
                    direction: Axis.horizontal,
                  ),
                ],
              ),
            ],
          ),
          nearbyPlacesModel.photo != null
              ? Image.network(
                nearbyPlacesModel.photo!,
                fit: BoxFit.cover,
                width: 140,
                height: 140,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.25,
                    ),
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                      strokeWidth: 2,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
              )
              : SizedBox(),
        ],
      ),
    );
  }
}
