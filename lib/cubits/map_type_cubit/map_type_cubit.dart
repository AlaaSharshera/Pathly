import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTypeCubit extends Cubit<MapType> {
  MapTypeCubit() : super( MapType.normal);
  MapType mapType = MapType.normal;
  void defaultMapType() {
    mapType =MapType.normal ;
    emit(mapType);
  }

  void hybridMapType() {
    mapType = MapType.hybrid;
    emit(mapType);
  }
}
