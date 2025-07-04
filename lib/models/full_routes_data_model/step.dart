import 'navigation_instruction.dart';

class StepModel {
  int? distanceMeters;
  String? staticDuration;
  NavigationInstruction? navigationInstruction;

  StepModel({this.distanceMeters, this.staticDuration, this.navigationInstruction});

  factory StepModel.fromJson(Map<String, dynamic> json) => StepModel(
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
