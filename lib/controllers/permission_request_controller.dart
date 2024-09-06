import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:optimize_battery/optimize_battery.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRequestController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    if (Platform.isAndroid) {
      await OptimizeBattery.stopOptimizingBatteryUsage();
    }
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
        openAppSettings();
      }
    }

    bool batteryPermissionGranted =
        await OptimizeBattery.isIgnoringBatteryOptimizations();
    if (batteryPermissionGranted == false) {
      OptimizeBattery.openBatteryOptimizationSettings();
    }
    if (allPermissionGranted(androidPermissionStatus) &&
        batteryPermissionGranted == true) {
      Get.toNamed('/login');
    }
  }

  bool allPermissionGranted(
    Map<Permission, PermissionStatus> androidPermissionStatus,
  ) {
    for (PermissionStatus status in androidPermissionStatus.values) {
      if (status.isDenied || status.isPermanentlyDenied) {
        return false;
      }
    }
    return true;
  }

  Future<void> requestIosPermissions() async {
    await [
      Permission.location,
    ].request();

    final types = [HealthDataType.STEPS];
    await Health().requestAuthorization(types);

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    Get.toNamed('/login');
  }
}
