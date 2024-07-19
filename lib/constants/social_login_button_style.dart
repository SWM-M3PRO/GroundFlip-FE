import 'package:flutter/material.dart';
import '../utils/social_login_button_style.dart';

class SocialLoginButtonStyles {
  static SocialLoginButtonStyle apple = SocialLoginButtonStyle(
    Colors.black,
    "assets/images/apple_logo.png",
    "Apple로 로그인",
    Colors.white,
  );

  static SocialLoginButtonStyle kakao = SocialLoginButtonStyle(
    Color(0xFFFEE500),
    "assets/images/kakao_logo.png",
    "카카오로 로그인",
    Colors.black,
  );
}
