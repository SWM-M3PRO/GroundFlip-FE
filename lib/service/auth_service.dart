import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../models/auth_response.dart';
import '../utils/dio_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  final Dio dio = DioService().getDio();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  Future<bool> isLogin() async {
    String? accessToken = await secureStorage.read(
      key: "accessToken",
    );
    String? refreshToken = await secureStorage.read(
      key: "refreshToken",
    );
    if (accessToken == null || refreshToken == null) {
      return false;
    } else {
      return true;
    }
  }

  loginWithKakao() async {
    String accessToken = await getKakaoAccessToken();
    AuthResponse authResponse = await postKakaoLogin(accessToken);
    await _saveTokens(authResponse);
    return authResponse;
  }

  Future<void> _saveTokens(AuthResponse authResponse) async {
    await secureStorage.write(
      key: "accessToken",
      value: authResponse.accessToken,
    );
    await secureStorage.write(
      key: "refreshToken",
      value: authResponse.refreshToken,
    );
  }

  Future<AuthResponse> postKakaoLogin(String accessToken) async {
    try {
      var response = await dio
          .post('/auth/kakao/login', data: {"accessToken": accessToken});
      return AuthResponse.fromJson(response.data["data"]);
    } catch (error) {
      throw Exception("로그인 실패");
    }
  }

  Future<String> getKakaoAccessToken() async {
    OAuthToken? token;
    if (await isKakaoTalkInstalled()) {
      token = await _loginWithKakaoTalkApp();
    } else {
      token = await _loginWithKakaoAccount();
    }
    return token.accessToken;
  }

  Future<OAuthToken> _loginWithKakaoTalkApp() async {
    OAuthToken? token;
    try {
      token = await UserApi.instance.loginWithKakaoTalk();
      debugPrint('카카오톡으로 로그인 성공 ${token.accessToken}');
    } catch (error) {
      debugPrint('카카오톡으로 로그인 실패 $error');

      if (error is PlatformException && error.code == 'CANCELED') {
        throw Exception("로그인 실패");
      }
      token = await _loginWithKakaoAccount();
    }
    return token;
  }

  Future<OAuthToken> _loginWithKakaoAccount() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      debugPrint('카카오계정으로 로그인 성공 ${token.accessToken}');
      return token;
    } catch (error) {
      debugPrint('카카오계정으로 로그인 실패 $error');
      throw Exception("로그인 실패");
    }
  }
}
