import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await checkPermissions();
  }

  Future<void> checkPermissions() async {
    if (Platform.isAndroid) {
      await requestAndroidPermissions();
    } else if (Platform.isIOS) {
      await requestIosPermissions();
    }
  }

  void exitApp() {
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
  }

  Future<void> requestAndroidPermissions() async {
    Map<Permission, PermissionStatus> androidPermissionStatus = await [
      Permission.location,
      Permission.activityRecognition,
      Permission.notification,
    ].request();

    for (PermissionStatus status in androidPermissionStatus.values) {
      if (status.isDenied || status.isPermanentlyDenied) {
        exitApp();
      }
    }
  }

  Future<void> requestIosPermissions() async {
    await [
      Permission.location,
    ].request();
    final types = [HealthDataType.STEPS];
    await Health().requestAuthorization(types);
  }
}
