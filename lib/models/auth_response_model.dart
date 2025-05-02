class RegisterResponseModel {
  final bool isAuthenticated;
  final String token;
  final String expiresOn;
  RegisterResponseModel({
    required this.expiresOn,
    required this.isAuthenticated,
    required this.token,
  });
  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      expiresOn: json['expiresOn'],
      isAuthenticated: json['isAuthenticated'],
      token: json['token'],
    );
  }
}
