import 'package:pathly/models/nearby_places_model/nearby_places_model.dart';

class GetNearbyPlacesStates {}
class LoadingNearbyPlacesState extends GetNearbyPlacesStates{}
class LoadedNearbyPlacesState extends GetNearbyPlacesStates{
 final List<NearbyPlacesModel>nearbyPlaces;
 LoadedNearbyPlacesState(this.nearbyPlaces);
}
class FailureNearbyPlacesState extends GetNearbyPlacesStates{
  final String errMessage;
  FailureNearbyPlacesState(this.errMessage);
}