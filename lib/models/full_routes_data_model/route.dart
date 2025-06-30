import 'leg.dart';
import 'polyline.dart';

class Route {
  List<Leg>? legs;
  int? distanceMeters;
  String? duration;
  Polyline? polyline;
  List<dynamic>? routeLabels;

  Route({
    this.legs,
    this.distanceMeters,
    this.duration,
    this.polyline,
    this.routeLabels,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    legs:
        (json['legs'] as List<dynamic>?)
            ?.map((e) => Leg.fromJson(e as Map<String, dynamic>))
            .toList(),
    distanceMeters: json['distanceMeters'] as int?,
    duration: json['duration'] as String?,
    polyline:
        json['polyline'] == null
            ? null
            : Polyline.fromJson(json['polyline'] as Map<String, dynamic>),
    routeLabels: json['routeLabels'] as List<dynamic>?,
  );

  Map<String, dynamic> toJson() => {
    'legs': legs?.map((e) => e.toJson()).toList(),
    'distanceMeters': distanceMeters,
    'duration': duration,
    'polyline': polyline?.toJson(),
    'routeLabels': routeLabels,
  };
}
