import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../controllers/setting_controller.dart';
import '../widgets/common/app_bar.dart';
import '../widgets/setting/setting_item.dart';
import '../widgets/setting/setting_section.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingController settingController = Get.put(SettingController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: AppBarTitle(
          title: '설정',
        ),
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: [
            SettingsSection(
              items: [
                SettingsItem(title: 'App Store 리뷰 남기기', isLast: true),
              ],
            ),
            SettingsSection(
              title: '알림',
              items: [
                SettingsItem(title: '알림 설정'),
                SettingsItem(title: '고객 문의 및 개선 요청', isLast: true),
              ],
            ),
            SettingsSection(
              title: '가이드',
              items: [
                SettingsItem(title: '공지사항'),
                SettingsItem(title: '플레이 가이드'),
                SettingsItem(title: '고객 문의 및 개선 요청', isLast: true),
              ],
            ),
            SettingsSection(
              title: '기타',
              items: [
                SettingsItem(title: '서비스 이용약관'),
                SettingsItem(title: '위치기반서비스 이용약관'),
                SettingsItem(title: '개인정보 처리 방침'),
                SettingsItem(
                  title: '버전 정보',
                  subTitle: "1.0.0",
                  isLast: true,
                ),
              ],
            ),
            SettingsSection(
              items: [
                SettingsItem(
                  title: '로그아웃',
                  onTap: () {
                    settingController.logout();
                  },
                ),
                SettingsItem(
                  title: '계정 탈퇴',
                  isAccent: true,
                  isLast: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
