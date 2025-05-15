import 'dart:developer';

import 'package:pathly/constant.dart';
import 'package:pathly/models/nearby_places_model/nearby_places_model.dart';
import 'package:pathly/utils/api.dart';

class GetNearbyPlacesService {
  Future<List<NearbyPlacesModel>> getNearbyPlaces({required double lat,required double lng,required String type}) async {
    try {
      List<dynamic> data = await Api().get(
        url:
            "$baseUrl/Places/nearby?lat=$lat&lng=$lng&radius=1000&type=$type",
      );
      List<NearbyPlacesModel> nearbyPlaces=[];
      for(int i=0;i<data.length;i++){
nearbyPlaces.add(NearbyPlacesModel.fromJson(data[i]));

      }
      log(nearbyPlaces[0].name.toString());
      return nearbyPlaces;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
