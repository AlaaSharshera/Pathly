import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng getProjectionOnSegment(LatLng p, LatLng a, LatLng b) {
    final dx = b.longitude - a.longitude;
    final dy = b.latitude - a.latitude;

    if (dx == 0 && dy == 0) return a;

    final t =
        ((p.longitude - a.longitude) * dx + (p.latitude - a.latitude) * dy) /
        (dx * dx + dy * dy);

    if (t <= 0)
     { return a;}
    else if (t >= 1)
     { return b;}
    else {
      return LatLng(a.latitude + t * dy, a.longitude + t * dx);
    }
  }