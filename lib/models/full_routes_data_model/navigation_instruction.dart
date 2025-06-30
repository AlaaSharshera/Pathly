class NavigationInstruction {
  String? maneuver;
  String? instructions;

  NavigationInstruction({this.maneuver, this.instructions});

  factory NavigationInstruction.fromJson(Map<String, dynamic> json) {
    return NavigationInstruction(
      maneuver: json['maneuver'] as String?,
      instructions: json['instructions'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'maneuver': maneuver,
    'instructions': instructions,
  };
}
