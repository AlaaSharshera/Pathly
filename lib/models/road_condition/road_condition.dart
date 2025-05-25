import 'point.dart';

class RoadCondition {
  String? clusterName;
  String? color;
  List<Point>? points;

  RoadCondition({this.clusterName, this.color, this.points});

  factory RoadCondition.fromJson(Map<String, dynamic> json) => RoadCondition(
    clusterName: json['clusterName'] as String?,
    color: json['color'] as String?,
    points:
        (json['points'] as List<dynamic>?)
            ?.map((e) => Point.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'clusterName': clusterName,
    'color': color,
    'points': points?.map((e) => e.toJson()).toList(),
  };
}
