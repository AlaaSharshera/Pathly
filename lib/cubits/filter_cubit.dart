import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCubit extends Cubit <String>{
  FilterCubit():super("");

  void chooseFilter(String filter){
    
    emit(filter);
  }
  
}