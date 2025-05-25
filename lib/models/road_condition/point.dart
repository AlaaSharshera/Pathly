class Point {
  double? latitude;
  double? longitude;

  Point({this.latitude, this.longitude});

  factory Point.fromJson(Map<String, dynamic> json) => Point(
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
  };
}
