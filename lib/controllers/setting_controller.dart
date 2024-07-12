import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/auth_service.dart';

class SettingController extends GetxController {
  final AuthService authService = AuthService();

  logout() async {
    _showLogoutDialog();
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('로그아웃 하시겠습니까?'),
        actions: [
          TextButton(
            child: Text('아니오'),
            onPressed: () async {
              await authService.logout();
              Get.back();
            },
          ),
          TextButton(
            child: Text('예'),
            onPressed: () async {
              await authService.logout();
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
