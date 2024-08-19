import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors.dart';
import '../models/version_response.dart';
import '../service/version_service.dart';

class VersionCheck {
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.m3pro.ground_flip';
  static const String appStoreUrl =
      "https://apps.apple.com/app/ground-flip/id6550922550";
  final VersionService versionService = VersionService();

  Future<dynamic> versionCheck() async{
    VersionResponse versionResponse = await versionService.getVersion();
    if (versionResponse.needUpdate == "NEED") {
      return Get.dialog(
        AlertDialog(
          title: Text(
            "앱의 최신버전이 존재합니다.",
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
                    if (Platform.isIOS) {
                      launchUrl(Uri.parse(appStoreUrl));
                    } else {
                      launchUrl(Uri.parse(playStoreUrl));
                    }
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
