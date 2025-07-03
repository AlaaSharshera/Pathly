import 'package:pathly/models/places_auto_complete_model/places_auto_complete.dart';
import 'package:pathly/models/places_details/places_details_model.dart';
import 'package:pathly/utils/api.dart';
import 'package:pathly/utils/api_keys.dart';

class GoogleMapsPlacesService {
  Future<List<PlacesAutoCompleteModel>> placesAutoComplteService({
    required String userInput,
    required String sessiontoken,
  }) async {
    try {
      var response = await Api().get(
        url:
            "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$userInput&key=${ApiKeys.placesApiKey}&sessiontoken=$sessiontoken",
      );
      var placesData = response["predictions"];
      List<PlacesAutoCompleteModel> places = [];
      for (var place in placesData) {
        places.add(PlacesAutoCompleteModel.fromJson(place));
      }

      return places;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PlacesDetailsModel> placeDetailsService({
    required String placeId,
    required String sessiontoken,
  }) async {
    try {
      var response = await Api().get(
        url:
            "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${ApiKeys.placesApiKey}&sessiontoken=$sessiontoken",
      );
      var placesData = response["result"];

      return PlacesDetailsModel.fromJson(placesData);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
