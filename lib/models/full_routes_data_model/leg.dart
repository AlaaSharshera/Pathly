import 'step.dart';

class Leg {
  int? distanceMeters;
  List<StepModel>? steps;

  Leg({this.distanceMeters, this.steps});

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
    distanceMeters: json['distanceMeters'] as int?,
    steps:
        (json['steps'] as List<dynamic>?)
            ?.map((e) => StepModel.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'distanceMeters': distanceMeters,
    'steps': steps?.map((e) => e.toJson()).toList(),
  };
}
