import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../models/permission.dart';
import '../service/auth_service.dart';
import '../service/permission_service.dart';
import '../service/user_service.dart';
import '../widgets/common/alert/alert.dart';

class SettingController extends GetxController {
  final AuthService authService = AuthService();
  final UserService userService = UserService();
  final PermissionService permissionService = PermissionService();
  late PackageInfo packageInfo;

  RxString currentVersion = ''.obs;
  late RxBool isServiceNotificationEnabled;
  late RxBool isMarketingNotificationEnabled;

  @override
  Future<void> onInit() async {
    await init();
    super.onInit();
  }

  Future<void> init() async {
    await setPageInfo();
    Permission permission = await permissionService.getPermission();
    currentVersion.value = packageInfo.version;
    update();
    isServiceNotificationEnabled = permission.isServiceNotificationEnabled.obs;
    isMarketingNotificationEnabled =
        permission.isMarketingNotificationEnabled.obs;
  }

  changeServiceNotificationStatus() async {
    bool changedStatus = !isServiceNotificationEnabled.value;
    try {
      await permissionService.updateServiceNotification(changedStatus);
      isServiceNotificationEnabled.value = changedStatus;
    } catch (e) {
      Get.dialog(Alert(title: "실패", content: "다시 시도 해주세요!", buttonText: "확인"));
    }
  }

  changeMarketingNotificationStatus() async {
    bool changedStatus = !isMarketingNotificationEnabled.value;
    try {
      await permissionService.updateMarketingNotification(changedStatus);
    } catch (e) {
      Get.dialog(Alert(title: "실패", content: "다시 시도 해주세요!", buttonText: "확인"));
    }
    isMarketingNotificationEnabled.value = changedStatus;
  }

  Future<void> setPageInfo() async {
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
        title: Text(
          '로그아웃 하시겠습니까?',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            child: Text('아니오', style: TextStyles.fs17w600cAccent),
            onPressed: () async {
              Get.back();
            },
          ),
          TextButton(
            child: Text('예', style: TextStyles.fs17w700cPrimary),
            onPressed: () async {
              await authService.logout();
              Get.offAllNamed('/login');
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColors.boxColor,
      ),
    );
  }

  void _showRemoveAccountDialog() {
    Get.dialog(
      AlertDialog(
        title: Text(
          '정말 탈퇴 하시겠습니까?',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        content: Text(
          '탈퇴 시 모든 정보가 즉시 삭제되며, 복구 할 수 없습니다.',
          style: TextStyles.fs17w400cTextSecondary,
        ),
        actions: [
          TextButton(
            child: Text('아니오', style: TextStyles.fs17w600cAccent),
            onPressed: () async {
              Get.back();
            },
          ),
          TextButton(
            child: Text('예', style: TextStyles.fs17w700cPrimary),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColors.boxColor,
      ),
    );
  }

  void _showFailDialog() {
    Get.dialog(
      AlertDialog(
        title: Text(
          '실패하였습니다.',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        content: Text(
          '잠시후 다시 시도해주세요.',
          style: TextStyles.fs17w400cTextSecondary,
        ),
        actions: [
          TextButton(
            child: Text('닫기', style: TextStyles.fs17w600cAccent),
            onPressed: () async {
              Get.back();
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColors.boxColor,
      ),
    );
  }
}
