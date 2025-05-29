import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavbarCubit extends Cubit<int> {
  BottomNavbarCubit() : super(2);

  void changePage(int index) {
    emit(index);
  }
}
