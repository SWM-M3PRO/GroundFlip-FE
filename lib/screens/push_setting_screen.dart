import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../widgets/common/app_bar.dart';
import '../widgets/setting/push_permission_item.dart';
import '../widgets/setting/setting_section.dart';

class PushSettingScreen extends StatelessWidget {
  const PushSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        title: AppBarTitle(
          title: "알림 설정",
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SettingsSection(
          items: [
            PushPermissionItem(
              title: '서비스 알림',
              subTitle: "매일 아침 동기 부여 알림을 받습니다.",
            ),
            PushPermissionItem(
              title: '마케팅 알림',
              subTitle: "앱의 이벤트, 소식, 해택 등을 알림을 받습니다.",
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}
