String formatDuration(String? duration) {
  if (duration == null || duration.isEmpty) {
    return '';
  }

  
  String cleaned = duration.replaceAll('s', '');
  int seconds = int.tryParse(cleaned) ?? 0;

  int minutes = (seconds / 60).round();
  if (minutes >= 60) {
    double hours = minutes / 60;
    return "${hours.toStringAsFixed(1)} hr";
  } else {
    return "$minutes min";
  }
}
