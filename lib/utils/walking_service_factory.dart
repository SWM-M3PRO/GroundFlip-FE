import 'dart:io';

import '../service/android_walking_service.dart';
import '../service/ios_walking_service.dart';
import 'walking_service.dart';

class WalkingServiceFactory {
  static WalkingService getWalkingService() {
    if (Platform.isIOS) {
      IosWalkingService().init();
      return IosWalkingService();
    } else if (Platform.isAndroid) {
      return AndroidWalkingService();
    } else {
      throw UnsupportedError('지원하지 않는 플랫폼입니다.');
    }
  }
}
