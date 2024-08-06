import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/auth_response.dart';
import '../service/auth_service.dart';
import '../utils/user_manager.dart';

class LoginController extends GetxController {
  final AuthService authService = AuthService();
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

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
      Get.toNamed('/policy');
    } else {
      Get.offAllNamed('/main');
      analytics.setUserId(id: UserManager().userId.toString());
    }
  }
}
