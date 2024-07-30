class LoginResponse {
  String? accessToken;
  String? refreshToken;
  bool? isSignUp;

  LoginResponse({
    this.accessToken,
    this.refreshToken,
    this.isSignUp,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    isSignUp = json['isSignUp'];
  }
}
