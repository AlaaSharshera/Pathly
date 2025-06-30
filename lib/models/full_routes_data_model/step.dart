import 'navigation_instruction.dart';

class Step {
  int? distanceMeters;
  String? staticDuration;
  NavigationInstruction? navigationInstruction;

  Step({this.distanceMeters, this.staticDuration, this.navigationInstruction});

  factory Step.fromJson(Map<String, dynamic> json) => Step(
    distanceMeters: json['distanceMeters'] as int?,
    staticDuration: json['staticDuration'] as String?,
    navigationInstruction:
        json['navigationInstruction'] == null
            ? null
            : NavigationInstruction.fromJson(
              json['navigationInstruction'] as Map<String, dynamic>,
            ),
  );

  Map<String, dynamic> toJson() => {
    'distanceMeters': distanceMeters,
    'staticDuration': staticDuration,
    'navigationInstruction': navigationInstruction?.toJson(),
  };
}
