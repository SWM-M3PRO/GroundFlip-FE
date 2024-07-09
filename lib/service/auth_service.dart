import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../models/auth_response.dart';
import '../utils/dio_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  final Dio dio = DioService().getDio();

  AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  postKakaoLogin(String accessToken) async {
    var response =
        await dio.post('/auth/kakao/login', data: {"accessToken": accessToken});

    return AuthResponse.fromJson(response.data["data"]);
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
      print('카카오톡으로 로그인 성공 ${token.accessToken}');
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');

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
      print('카카오계정으로 로그인 성공 ${token.accessToken}');
      return token;
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
      throw Exception("로그인 실패");
    }
  }
}
