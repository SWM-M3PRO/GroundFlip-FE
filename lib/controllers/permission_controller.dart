import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

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

    androidPermissionStatus.values.forEach((element) async {
      if (element.isDenied || element.isPermanentlyDenied) {
        exitApp();
      }
    });
  }

  Future<void> requestIosPermissions() async {
    Map<Permission, PermissionStatus> iosPermissionStatus = await [
      Permission.location,
      Permission.sensors,
    ].request();

    iosPermissionStatus.values.forEach((element) async {
      if (element.isDenied || element.isPermanentlyDenied) {
        exitApp();
      }
    });
  }
}
