import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../service/android_walking_service.dart';
import '../service/fcm_service.dart';
import '../service/my_place_service.dart';

class MainController extends GetxController {
  final FcmService fcmService = FcmService();
  final MyPlaceService myPlaceService = MyPlaceService();

  final RxBool internetCheck = true.obs;
  final RxBool isAlertIsShow = false.obs;

  @override
  void onInit() async {
    super.onInit();
    fcmService.registerFcmToken();
    myPlaceService.getMyPlaceInfo();
    AndroidWalkingService().postAllUserStepFromStorage();
    checkLocationPermission();
  }

  Future<void> checkLocationPermission() async {
    PermissionStatus status = await Permission.locationAlways.status;

    if (status != PermissionStatus.granted) {
      _showRequestLocationAlways();
    }
  }

  void _showRequestLocationAlways() {
    Get.dialog(
      AlertDialog(
        title: Text(
          '위치 권한을 "항상 허용"으로 바꿔주세요!',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        content: Text(
          '앱을 켜지 않아도 땅따먹기를 할 수 있어요!',
          style: TextStyles.fs17w400cTextSecondary,
        ),
        actions: [
          TextButton(
            child: Text(
              '아니오',
              style: TextStyles.fs17w600cAccent,
            ),
            onPressed: () async {
              Get.back();
            },
          ),
          TextButton(
            child: Text(
              '예',
              style: TextStyles.fs17w700cPrimary,
            ),
            onPressed: () {
              openAppSettings();
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
