import 'location.dart';

class NearbyPlacesModel {
  String? name;
  String? address;
  double? rating;
  Location? location;
  String? photo;

  NearbyPlacesModel({
    this.name,
    this.address,
    this.rating,
    this.location,
    this.photo,
  });

  factory NearbyPlacesModel.fromJson(Map<String, dynamic> json) {
    return NearbyPlacesModel(
      name: json['Name'] as String?,
      address: json['Address'] as String?,
      rating: (json['Rating'] as num?)?.toDouble(),
      location:
          json['Location'] == null
              ? null
              : Location.fromJson(json['Location'] as Map<String, dynamic>),
      photo: json['Photo'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'Name': name,
    'Address': address,
    'Rating': rating,
    'Location': location?.toJson(),
    'Photo': photo,
  };
}
