import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathly/cubits/get_nearby_places_cubit/get_nearby_places_states.dart';
import 'package:pathly/models/nearby_places_model/nearby_places_model.dart';
import 'package:pathly/services/get_nearbyplaces_service.dart';

class GetNearbyPlacesCubit extends Cubit<GetNearbyPlacesStates>{
  GetNearbyPlacesCubit():super(LoadingNearbyPlacesState());
  Future getNearbyPlaces({required double lat,required double lng,required String type})async{
    try{
      emit(LoadingNearbyPlacesState());
      List<NearbyPlacesModel> nearbyPlaces=await GetNearbyPlacesService().getNearbyPlaces(lat: lat, lng: lng, type: type);
      emit(LoadedNearbyPlacesState(nearbyPlaces));
    }catch(e){
      emit(FailureNearbyPlacesState(e.toString()));
    }
  }

   Future getAllNearbyPlaces({required double lat,required double lng})async{
    try{
      emit(LoadingNearbyPlacesState());
      
      List<NearbyPlacesModel> allPlaces=[];
      final types = ["tourist_attraction","clothing_store","hospital","lodging",'cafe','car_wash', 'gym','pharmacy', 'restaurant','gas_station'];
      
for (final type in types) {
        final places = await GetNearbyPlacesService().getNearbyPlaces(lat: lat, lng: lng, type: type);
        allPlaces.addAll(places);}
        allPlaces.shuffle();
      emit(LoadedNearbyPlacesState(allPlaces));
    }catch(e){
      emit(FailureNearbyPlacesState(e.toString()));
    }
  }

  Future getCarServiceNearbyPlaces({required double lat,required double lng})async{
    try{
      emit(LoadingNearbyPlacesState());
      
      List<NearbyPlacesModel> allPlaces=[];
      final types = ['gas_station', 'car_repair','car_dealer', 'car_wash'];
      
for (final type in types) {
        final places = await GetNearbyPlacesService().getNearbyPlaces(lat: lat, lng: lng, type: type);
        allPlaces.addAll(places);}
        allPlaces.shuffle();
      emit(LoadedNearbyPlacesState(allPlaces));
    }catch(e){
      emit(FailureNearbyPlacesState(e.toString()));
    }
  }


}

 