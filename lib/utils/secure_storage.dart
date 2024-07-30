import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  SecureStorage._internal();

  factory SecureStorage() {
    return _instance;
  }

  readAccessToken() async {
    return await secureStorage.read(
      key: "accessToken",
    );
  }

  readRefreshToken() async {
    return await secureStorage.read(
      key: "refreshToken",
    );
  }

  readSignupStatus() async {
    return await secureStorage.read(
      key: "signupStatus",
    );
  }

  writeAccessToken(accessToken) async {
    await secureStorage.write(
      key: "accessToken",
      value: accessToken,
    );
  }

  writeRefreshToken(refreshToken) async {
    await secureStorage.write(
      key: "refreshToken",
      value: refreshToken,
    );
  }

  writeSignupStatus(String status) async {
    await secureStorage.write(
      key: "signupStatus",
      value: status,
    );
  }

  deleteAccessToken() async {
    await secureStorage.delete(key: "accessToken");
  }

  deleteRefreshToken() async {
    await secureStorage.delete(key: "refreshToken");
  }
}
