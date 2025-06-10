import 'lat_lng.dart';

class LocationInfo {
  LatLngModel? latLng;

  LocationInfo({this.latLng});

  factory LocationInfo.fromJson(Map<String, dynamic> json) => LocationInfo(
    latLng:
        json['latLng'] == null
            ? null
            : LatLngModel.fromJson(json['latLng'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {'latLng': latLng?.toJson()};
}
