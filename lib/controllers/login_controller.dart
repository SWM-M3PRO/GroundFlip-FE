import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/auth_response.dart';
import '../service/auth_service.dart';

class LoginController extends GetxController {
  final AuthService authService = AuthService();

  loginWithApple() async {
    try {
      LoginResponse loginResponse = await authService.loginWithApple();
      _navigateAfterLogin(loginResponse);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  loginWithKakao() async {
    try {
      LoginResponse loginResponse = await authService.loginWithKakao();
      _navigateAfterLogin(loginResponse);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  _navigateAfterLogin(LoginResponse loginResponse) {
    if (loginResponse.isSignUp!) {
      Get.toNamed('/signup');
    } else {
      Get.offAllNamed('/main');
    }
  }
}
