class AuthResponse {
  String? accessToken;
  String? refreshToken;
  bool? isSignUp;

  AuthResponse({
    this.accessToken,
    this.refreshToken,
    this.isSignUp,
  });

  AuthResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    isSignUp = json['isSignUp'];
  }
}
