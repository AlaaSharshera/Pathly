String formatDistance(int? meters) {
  final int distance = meters ?? 0;

  if (distance < 1000) {
    return "$distance m";
  } else {
    final km = (distance / 1000).toStringAsFixed(1);
    return "$km KM";
  }
}
