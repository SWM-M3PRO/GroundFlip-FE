import 'package:flutter/material.dart';

import '../widgets/setting/setting_item.dart';
import '../widgets/setting/setting_section.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('설정'),
      ),
      body: ListView(
        children: [
          SettingsSection(
            title: '설정',
            items: [
              SettingsItem(title: '수령 정보 설정'),
              SettingsItem(title: '알림 설정'),
              SettingsItem(title: '맵 설정'),
              SettingsItem(title: '실험실'),
              SettingsItem(title: '앱 최적화'),
              SettingsItem(title: 'App Store 리뷰 남기기'),
            ],
          ),
          SettingsSection(
            title: '가이드',
            items: [
              SettingsItem(title: '공지사항'),
              SettingsItem(title: '플레이 가이드'),
              SettingsItem(title: '고객 문의 및 개선 요청'),
            ],
          ),
          SettingsSection(
            title: '기타',
            items: [
              SettingsItem(title: '서비스이용약관'),
              SettingsItem(
                title: '로그아웃',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
