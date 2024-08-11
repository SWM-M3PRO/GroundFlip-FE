import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors.dart';
import '../models/version_response.dart';
import '../service/fcm_service.dart';
import '../service/my_place_service.dart';
import '../service/version_service.dart';

class MainController extends GetxController {
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.m3pro.ground_flip';
  final FcmService fcmService = FcmService();
  final MyPlaceService myPlaceService = MyPlaceService();
  final VersionService versionService = VersionService();

  final RxBool internetCheck = true.obs;
  final RxBool isAlertIsShow = false.obs;

  @override
  void onInit() async {
    super.onInit();
    fcmService.registerFcmToken();
    myPlaceService.getMyPlaceInfo();
  }

  Future<dynamic> checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    VersionResponse versionResponse = await versionService.getVersion();
    String currentVersion = packageInfo.version;
    if (versionResponse.version != currentVersion) {
      return Get.dialog(
        AlertDialog(
          title: Text(
            "앱을 업데이트 해주세요!",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0),
                child: TextButton(
                  child: Text(
                    '업데이트',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 17,
                    ),
                  ),
                  onPressed: () async {
                    launchUrl(Uri.parse(playStoreUrl));
                  },
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: AppColors.boxColor,
        ),
      );
    } else {
      return Container();
    }
  }
}
