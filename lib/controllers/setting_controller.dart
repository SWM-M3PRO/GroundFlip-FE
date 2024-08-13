import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../constants/text_styles.dart';
import '../service/auth_service.dart';
import '../service/user_service.dart';

class SettingController extends GetxController {
  final AuthService authService = AuthService();
  final UserService userService = UserService();
  late PackageInfo packageInfo;
  late String currentVersion;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async{
    await setPageInfo();
    currentVersion = packageInfo.version;
    update();
  }

  Future<void> setPageInfo() async{
    packageInfo = await PackageInfo.fromPlatform();
  }

  logout() async {
    _showLogoutDialog();
  }

  removeAccount() {
    _showRemoveAccountDialog();
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('로그아웃 하시겠습니까?'),
        actions: [
          TextButton(
            child: Text('아니오', style: TextStyles.fs17w600cAccent),
            onPressed: () async {
              Get.back();
            },
          ),
          TextButton(
            child: Text('예', style: TextStyles.fs17w600cTextBlack),
            onPressed: () async {
              await authService.logout();
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
    );
  }

  void _showRemoveAccountDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('정말 탈퇴 하시겠습니까?'),
        content: Text('탈퇴 시 모든 정보가 즉시 삭제되며, 복구 할 수 없습니다.'),
        actions: [
          TextButton(
            child: Text('아니오', style: TextStyles.fs17w600cAccent),
            onPressed: () async {
              Get.back();
            },
          ),
          TextButton(
            child: Text('예', style: TextStyles.fs17w600cTextBlack),
            onPressed: () async {
              try {
                Get.back();
                await userService.deleteUser();
                Get.offAllNamed('/login');
              } catch (e) {
                _showFailDialog();
              }
            },
          ),
        ],
      ),
    );
  }

  void _showFailDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('실패하였습니다.'),
        content: Text('잠시후 다시 시도해주세요.'),
        actions: [
          TextButton(
            child: Text('닫기', style: TextStyles.fs17w600cAccent),
            onPressed: () async {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
