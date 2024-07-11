class ReissueResponse {
  String? accessToken;
  String? refreshToken;

  ReissueResponse({
    this.accessToken,
    this.refreshToken,
  });

  ReissueResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }
}
