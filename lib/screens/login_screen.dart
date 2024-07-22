import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/social_login_button_style.dart';
import '../constants/text_styles.dart';
import '../controllers/login_controller.dart';
import '../widgets/login/social_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Center(
          child: Image.asset(
            "assets/images/groundflip_logo.png",
            height: 32,
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.asset("assets/images/login_image.png"),
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.yellow,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff000000),
                          Color(0x0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "내가 가는 길이,",
                          style: TextStyles.fs32w400cTextSecondary,
                        ),
                      ),
                      Text(
                        "내 것이 되는 즐거움",
                        style: TextStyles.fs32w900cTextPrimary,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            if (!Platform.isAndroid)
              SocialLoginButton(
                socialLoginButtonStyle: SocialLoginButtonStyles.apple,
                onTap: () => loginController.loginWithApple(),
              ),
            if (!Platform.isAndroid)
              SizedBox(
                height: 20,
              ),
            if (Platform.isAndroid)
              SizedBox(
                height: 100,
              ),
            SocialLoginButton(
              socialLoginButtonStyle: SocialLoginButtonStyles.kakao,
              onTap: () => loginController.loginWithKakao(),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
