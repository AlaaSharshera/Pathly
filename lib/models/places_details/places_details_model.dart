import 'address_component.dart';
import 'geometry.dart';
import 'photo.dart';
import 'review.dart';

class PlacesDetailsModel {
  List<AddressComponent>? addressComponents;
  String? adrAddress;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  List<Photo>? photos;
  String? placeId;
  double? rating;
  String? reference;
  List<Review>? reviews;
  List<dynamic>? types;
  String? url;
  int? userRatingsTotal;
  int? utcOffset;

  PlacesDetailsModel({
    this.addressComponents,
    this.adrAddress,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.photos,
    this.placeId,
    this.rating,
    this.reference,
    this.reviews,
    this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
  });

  factory PlacesDetailsModel.fromJson(Map<String, dynamic> json) =>
      PlacesDetailsModel(
        addressComponents:
            (json['address_components'] as List<dynamic>?)
                ?.map(
                  (e) => AddressComponent.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
        adrAddress: json['adr_address'] as String?,
        formattedAddress: json['formatted_address'] as String?,
        geometry:
            json['geometry'] == null
                ? null
                : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
        icon: json['icon'] as String?,
        iconBackgroundColor: json['icon_background_color'] as String?,
        iconMaskBaseUri: json['icon_mask_base_uri'] as String?,
        name: json['name'] as String?,
        photos:
            (json['photos'] as List<dynamic>?)
                ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
                .toList(),
        placeId: json['place_id'] as String?,
        rating: (json['rating'] as num?)?.toDouble(),
        reference: json['reference'] as String?,
        reviews:
            (json['reviews'] as List<dynamic>?)
                ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
                .toList(),
        types: json['types'] as List<dynamic>?,
        url: json['url'] as String?,
        userRatingsTotal: json['user_ratings_total'] as int?,
        utcOffset: json['utc_offset'] as int?,
      );

  Map<String, dynamic> toJson() => {
    'address_components': addressComponents?.map((e) => e.toJson()).toList(),
    'adr_address': adrAddress,
    'formatted_address': formattedAddress,
    'geometry': geometry?.toJson(),
    'icon': icon,
    'icon_background_color': iconBackgroundColor,
    'icon_mask_base_uri': iconMaskBaseUri,
    'name': name,
    'photos': photos?.map((e) => e.toJson()).toList(),
    'place_id': placeId,
    'rating': rating,
    'reference': reference,
    'reviews': reviews?.map((e) => e.toJson()).toList(),
    'types': types,
    'url': url,
    'user_ratings_total': userRatingsTotal,
    'utc_offset': utcOffset,
  };
}
