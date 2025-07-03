import 'route.dart';

class FullRoutesDataModel {
  List<RouteModel>? routes;

  FullRoutesDataModel({this.routes});

  factory FullRoutesDataModel.fromJson(Map<String, dynamic> json) {
    return FullRoutesDataModel(
      routes:
          (json['routes'] as List<dynamic>?)
              ?.map((e) => RouteModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'routes': routes?.map((e) => e.toJson()).toList(),
  };
}
