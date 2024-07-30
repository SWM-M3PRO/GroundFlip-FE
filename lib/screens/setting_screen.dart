import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors.dart';
import '../controllers/setting_controller.dart';
import '../widgets/common/app_bar.dart';
import '../widgets/setting/setting_item.dart';
import '../widgets/setting/setting_section.dart';
import 'on_board_screen.dart';

class SettingScreen extends StatelessWidget {
  static String individualInfoPolicyUrl =
      'https://autumn-blouse-355.notion.site/e338b4179e5248eebe4c5827b347307b?pvs=4';
  static String serviceUsePolicyUrl =
      'https://autumn-blouse-355.notion.site/58919803d41b40fba9ec0344625e94da?pvs=4';
  static String placeServicePolicyUrl =
      'https://autumn-blouse-355.notion.site/ab3799e4818249daa3bfc32c7f44089d?pvs=4';
  static String usageGuideUrl =
      'https://autumn-blouse-355.notion.site/e9414fa20bef4021b5e7193dd3e2e77d';

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
            // SettingsSection(
            //   items: [
            //     SettingsItem(title: 'App Store 리뷰 남기기',
            //       isLast: true,),
            //   ],
            // ),
            // SettingsSection(
            //   title: '알림',
            //   items: [
            //     SettingsItem(title: '알림 설정'),
            //     SettingsItem(title: '고객 문의 및 개선 요청', isLast: true),
            //   ],
            // ),
            SettingsSection(
              title: '가이드',
              items: [
                // SettingsItem(
                //   title: '공지사항',
                //   onTap: () async {
                //     final Uri url = Uri.parse('https://flutter.dev');
                //     await launchUrl(url);
                //   },
                // ),
                SettingsItem(
                  title: '사용 가이드',
                  onTap: () {
                    Get.to(() => OnBoardScreen());
                  },
                  isLast: true,
                ),
                // SettingsItem(title: '고객 문의 및 개선 요청', isLast: true),
              ],
            ),
            SettingsSection(
              title: '기타',
              items: [
                SettingsItem(
                  title: '서비스 이용약관',
                  onTap: () {
                    launchUrl(Uri.parse(individualInfoPolicyUrl));
                  },
                ),
                SettingsItem(
                  title: '위치기반서비스 이용약관',
                  onTap: () {
                    launchUrl(Uri.parse(serviceUsePolicyUrl));
                  },
                ),
                SettingsItem(
                  title: '개인정보 처리 방침',
                  onTap: () {
                    launchUrl(Uri.parse(placeServicePolicyUrl));
                  },
                ),
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
                  onTap: () {
                    settingController.removeAccount();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
