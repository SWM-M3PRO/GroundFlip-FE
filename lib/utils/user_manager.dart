import 'secure_storage.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();
  final SecureStorage secureStorage = SecureStorage();

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  int? userId;
  String? accessToken;
  String? refreshToken;
  bool? isTokenReissued;

  void init() {
    userId = null;
    accessToken = null;
    refreshToken = null;
    isTokenReissued = null;
  }

  updateSecureStorage() {
    if (isTokenReissued == true) {
      secureStorage.writeAccessToken(accessToken);
      secureStorage.writeRefreshToken(refreshToken);
    }
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

  void setTokenReissued() {
    isTokenReissued = true;
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
