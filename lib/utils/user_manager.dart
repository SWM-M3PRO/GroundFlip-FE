class UserManager {
  static final UserManager _instance = UserManager._internal();

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  int? userId;
  String? accessToken;
  String? refreshToken;

  void init() {
    userId = null;
    accessToken = null;
    refreshToken = null;
  }

  void setUserId(int id) {
    userId = id;
  }

  void setAccessToken(String accessToken) {
    this.accessToken = accessToken;
  }

  void setRefreshToken(String refreshToken) {
    this.refreshToken = refreshToken;
  }

  int? getUserId() {
    return userId;
  }

  String getAccessToken() {
    return accessToken ?? "token";
  }

  String getRefreshToken() {
    return refreshToken ?? "token";
  }
}
