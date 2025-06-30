import 'route.dart';

class FullRoutesDataModel {
  List<Route>? routes;

  FullRoutesDataModel({this.routes});

  factory FullRoutesDataModel.fromJson(Map<String, dynamic> json) {
    return FullRoutesDataModel(
      routes:
          (json['routes'] as List<dynamic>?)
              ?.map((e) => Route.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'routes': routes?.map((e) => e.toJson()).toList(),
  };
}
