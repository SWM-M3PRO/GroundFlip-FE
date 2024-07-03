import 'dart:isolate';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import 'walking_service.dart';
import 'walking_service_factory.dart';

// AndroidWalkingController androidWalkingController =
//     Get.put(AndroidWalkingController());

// print(androidWalkingService);

Future<void> initForegroundTask() async {
  WalkingService androidWalkingService =
      WalkingServiceFactory.getWalkingService();
  print('initForeGround 생성 ${androidWalkingService.hashCode}');
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'ground-flip',
      channelName: 'ground-flip Notification',
      channelDescription:
          'This notification appears when the ground-flip is running.',
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
      interval: 1000,
      isOnceEvent: false,
      autoRunOnBoot: true,
      allowWakeLock: true,
      allowWifiLock: true,
    ),
  );
  FlutterForegroundTask.startService(
    notificationTitle: "걸음수",
    notificationText: (await androidWalkingService.getCurrentStep).toString(),
    callback: startCallback,
  );
}

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(FirstTaskHandler());
}

class FirstTaskHandler extends TaskHandler {
  WalkingService androidWalkingService =
      WalkingServiceFactory.getWalkingService();

  // print('initForeGround 생성 ${androidWalkingService.hashCode}');
  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {}

  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    int updateStep = await androidWalkingService.getCurrentStep();
    FlutterForegroundTask.updateService(
      notificationTitle: "걸음수",
      notificationText: updateStep.toString(),
    );
  }

  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) async {}
}
