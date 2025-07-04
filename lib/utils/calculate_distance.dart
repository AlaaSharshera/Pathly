  import 'dart:math' as math;

// double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
//     const double p = 0.017453292519943295;
//     final double a =
//         0.5 -
//         math.cos((lat2 - lat1) * p) / 2 +
//         math.cos(lat1 * p) *
//             math.cos(lat2 * p) *
//             (1 - math.cos((lon2 - lon1) * p)) /
//             2;
//     return 12742 * math.asin(math.sqrt(a));
//   }
import 'dart:math';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371000; // meters
  double dLat = _toRadians(lat2 - lat1);
  double dLon = _toRadians(lon2 - lon1);
  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
      sin(dLon / 2) * sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return earthRadius * c;
}

double _toRadians(double degrees) {
  return degrees * pi / 180;
}
