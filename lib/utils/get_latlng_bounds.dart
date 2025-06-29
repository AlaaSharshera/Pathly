
  import 'dart:math' as math;

import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLngBounds getLatLngBounds(List<LatLng> points) {
    var southWestLatitude = points.first.latitude;
    var southWestLongtiude = points.first.longitude;
    var nourthEastLatiude = points.first.latitude;
    var nourthEastLongtiude = points.first.longitude;
    for (var point in points) {
      southWestLatitude = math.min(southWestLatitude, point.latitude);
      southWestLongtiude = math.min(southWestLongtiude, point.longitude);
      nourthEastLatiude = math.max(nourthEastLatiude, point.latitude);
      nourthEastLongtiude = math.max(nourthEastLongtiude, point.longitude);
    }
    LatLng southwest = LatLng(southWestLatitude, southWestLongtiude);
    LatLng northeast = LatLng(nourthEastLatiude, nourthEastLongtiude);
    return LatLngBounds(southwest: southwest, northeast: northeast);
  }