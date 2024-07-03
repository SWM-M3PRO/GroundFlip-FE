import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';

import 'controllers/android_walking_controller.dart';
import 'screens/main_screen.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

final AndroidWalkingController androidWalkingController = Get.put(AndroidWalkingController());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void _initForegroundTask() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'ground-flip',
        channelName: 'ground-flip Notification',
        channelDescription: 'This notification appears when the ground-flip is running.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000,
        isOnceEvent: false,
        autoRunOnBoot: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );

    FlutterForegroundTask.startService(
        notificationTitle: "ground-flip 걸음수",
        notificationText: androidWalkingController.currentSteps.value.toString(),
        callback: startCallback
    );
  }

  @override
  Widget build(BuildContext context) {
    _initForegroundTask();
    return GetMaterialApp(
      title: 'Ground Flip',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/main',
      getPages: [
        GetPage(name: '/main', page: () => const MainScreen()),
      ],
    );
  }
}

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(FirstTaskHandler());
}

class FirstTaskHandler extends TaskHandler {

  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {
  }

  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    int updateStep = androidWalkingController.currentSteps.value;

    FlutterForegroundTask.updateService(
      notificationTitle: "걸음수",
      notificationText: updateStep.toString(),
    );
  }

  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) async {}
}
