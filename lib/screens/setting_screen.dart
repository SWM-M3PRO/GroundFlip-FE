import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors.dart';
import '../controllers/setting_controller.dart';
import '../widgets/common/app_bar.dart';
import '../widgets/setting/setting_item.dart';
import '../widgets/setting/setting_section.dart';
import 'announcement_list_screen.dart';
import 'push_setting_screen.dart';

class SettingScreen extends StatelessWidget {
  static String policyUrl =
      'https://autumn-blouse-355.notion.site/eb53cab4f7a24135babca2c6b8ebde1c?pvs=4';
  static String individualInfoPolicyUrl =
      'https://autumn-blouse-355.notion.site/e338b4179e5248eebe4c5827b347307b?pvs=4';
  static String serviceUsePolicyUrl =
      'https://autumn-blouse-355.notion.site/58919803d41b40fba9ec0344625e94da?pvs=4';
  static String placeServicePolicyUrl =
      'https://autumn-blouse-355.notion.site/ab3799e4818249daa3bfc32c7f44089d?pvs=4';
  static String usageGuideUrl =
      'https://autumn-blouse-355.notion.site/e9414fa20bef4021b5e7193dd3e2e77d';
  static String playGuideUrl =
      'https://www.notion.so/e9414fa20bef4021b5e7193dd3e2e77d';
  static String customerSupportUrl = 'https://open.kakao.com/o/gH1dV7Eg';
  static String announcementUrl =
      'https://autumn-blouse-355.notion.site/009bea49570a42679153e9f48b010ffc?v=eea22d1fd25b42488a54cc1c49b7e216&pvs=4';
  final String appStoreId = dotenv.env['APP_ID']!;

  SettingScreen({super.key});

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
              title: '버전 정보',
              items: [
                Obx(() => SettingsItem(
                  title: '현재 버전',
                  subTitle: settingController.currentVersion.value,
                  isLast: true,
                ),
                ),
              ],
            ),
            SettingsSection(
              items: [
                SettingsItem(
                  title: '알림 설정',
                  onTap: () {
                    Get.to(PushSettingScreen());
                  },
                ),
                SettingsItem(
                  title:
                      Platform.isIOS ? 'App Store 리뷰 남기기' : 'playstore 리뷰 남기기',
                  onTap: () {
                    final inAppReview = InAppReview.instance;
                    inAppReview.openStoreListing(
                      appStoreId: appStoreId,
                    );
                  },
                  isLast: true,
                ),
              ],
            ),
            SettingsSection(
              title: '공지사항 및 문의',
              items: [
                SettingsItem(
                  title: '문의를 위한 오픈 채팅방',
                  onTap: () {
                    launchUrl(Uri.parse(customerSupportUrl));
                  },
                ),
                SettingsItem(
                  title: '공지사항',
                  onTap: () async {
                    Get.to(AnnouncementListScreen());
                  },
                  isLast: true,

                ),
              ],
            ),
            SettingsSection(
              title: '약관',
              items: [
                SettingsItem(
                  title: '개인정보처리방침',
                  onTap: () {
                    launchUrl(Uri.parse(individualInfoPolicyUrl));
                  },
                ),
                SettingsItem(
                  title: '서비스이용약관',
                  onTap: () {
                    launchUrl(Uri.parse(serviceUsePolicyUrl));
                  },
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
