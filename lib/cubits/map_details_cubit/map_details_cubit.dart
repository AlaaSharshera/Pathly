import 'package:flutter_bloc/flutter_bloc.dart';

class MapDetailsCubit extends Cubit<String> {
  MapDetailsCubit() : super("Road Condition");
  String mapDetails = "Road Condition";

  void trafficCase() {
    mapDetails = "Traffic";
    emit(mapDetails);
  }

  void roadConditionCase() {
    mapDetails = "Road Condition";
    emit(mapDetails);
  }
}
