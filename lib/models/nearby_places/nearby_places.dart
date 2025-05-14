import 'location.dart';

class NearbyPlaces {
  String? name;
  String? address;
  int? rating;
  Location? location;

  NearbyPlaces({this.name, this.address, this.rating, this.location});

  factory NearbyPlaces.fromJson(Map<String, dynamic> json) => NearbyPlaces(
    name: json['name'] as String?,
    address: json['address'] as String?,
    rating: json['rating'] as int?,
    location:
        json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'rating': rating,
    'location': location?.toJson(),
  };
}
