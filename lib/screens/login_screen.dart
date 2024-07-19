import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/social_login_button_style.dart';
import '../controllers/login_controller.dart';
import '../widgets/login/social_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/ground_flip_logo.png',
              width: 180,
              height: 180,
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "내가 가는 길이, \n내 것이 되는 즐거움",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 250,
            ),
            if (!Platform.isAndroid)
              SocialLoginButton(
                socialLoginButtonStyle: SocialLoginButtonStyles.apple,
                onTap: () => loginController.loginWithApple(),
              ),
            if (!Platform.isAndroid)
              SizedBox(
                height: 10,
              ),
            SocialLoginButton(
              socialLoginButtonStyle: SocialLoginButtonStyles.kakao,
              onTap: () => loginController.loginWithKakao(),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
