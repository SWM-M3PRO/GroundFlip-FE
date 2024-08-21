import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ground_flip/screens/sign_up_screen.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../service/permission_service.dart';

class MarketingPushPermissionAlert extends StatelessWidget {
  MarketingPushPermissionAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "광고성 정보 수신 동의",
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      content: Text(
        "푸시 알림을 통해 그라운드 플립의 이벤트, 소식, 해택 등을 전달해드리려고 합니다. \n\n앱 푸시에 동의하시겠습니까?",
        style: TextStyles.fs17w400cTextSecondary,
      ),
      actions: [
        TextButton(
          child: Text(
            "미동의",
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          onPressed: () {
            Get.to(() => SignUpScreen());
          },
        ),
        TextButton(
          child: Text(
            "동의",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          onPressed: () {
            PermissionService().updateMarketingNotification(true);
            Get.to(() => SignUpScreen());
          },
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: AppColors.boxColor,
    );
  }
}
