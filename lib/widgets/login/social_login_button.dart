import 'package:flutter/material.dart';

import '../../utils/social_login_button_style.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final SocialLoginButtonStyle socialLoginButtonStyle;

  const SocialLoginButton({
    super.key,
    required this.onTap,
    required this.socialLoginButtonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
        height: 64,
        decoration: BoxDecoration(
          color: socialLoginButtonStyle.backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                socialLoginButtonStyle.logoAsset,
                width: 20,
                height: 20,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                socialLoginButtonStyle.buttonText,
                style: TextStyle(
                  color: socialLoginButtonStyle.textColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
