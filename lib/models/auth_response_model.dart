class AuthResponseModel {
  final bool isAuthenticated;
  final String token;
  final String expiresOn;
  AuthResponseModel({
    required this.expiresOn,
    required this.isAuthenticated,
    required this.token,
  });
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      expiresOn: json['expiresOn'],
      isAuthenticated: json['isAuthenticated'],
      token: json['token'],
    );
  }
}
