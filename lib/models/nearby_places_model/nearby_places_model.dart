import 'location.dart';

class NearbyPlacesModel {
  String? name;
  String? address;
  double? rating;
  Location? location;

  NearbyPlacesModel({this.name, this.address, this.rating, this.location});

  factory NearbyPlacesModel.fromJson(Map<String, dynamic> json) => NearbyPlacesModel(
    name: json['name'] as String?,
    address: json['address'] as String?,
    rating: (json['rating'] as num?)?.toDouble(),
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
