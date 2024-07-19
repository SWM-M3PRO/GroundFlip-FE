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
        width: 400,
        height: 60,
        decoration: BoxDecoration(
          color: socialLoginButtonStyle.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              socialLoginButtonStyle.logoAsset,
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              socialLoginButtonStyle.buttonText,
              style: TextStyle(
                color: socialLoginButtonStyle.textColor,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
