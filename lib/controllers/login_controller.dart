import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/auth_response.dart';
import '../service/auth_service.dart';

class LoginController extends GetxController {
  final AuthService authService = AuthService();

  loginWithKakao() async {
    try {
      AuthResponse authResponse = await authService.loginWithKakao();
      if (authResponse.isSignUp!) {
        Get.toNamed('/signup');
      } else {
        Get.offAllNamed('/main');
      }
    } catch (err) {
      showErrorDialog("실패");
    }
  }

  void showErrorDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: Text('로그인을 실패하였습니다.'),
        actions: [
          TextButton(
            child: Text('확인'),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
