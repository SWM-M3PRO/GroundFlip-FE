import 'dart:io';

import '../service/android_walking_service.dart';
import '../service/ios_walking_service.dart';
import 'walking_service.dart';

class WalkingServiceFactory {
  static WalkingService getWalkingService() {
    if (Platform.isIOS) {
      return IosWalkingService();
    } else if (Platform.isAndroid) {
      var androidWalkingService = AndroidWalkingService();
      if (androidWalkingService.isInit == false) {
        print('초기화');
        androidWalkingService.initPlatformState();
      }
      print('팩토리 생성 ${androidWalkingService.hashCode}');
      return AndroidWalkingService();
    } else {
      throw UnsupportedError('지원하지 않는 플랫폼입니다.');
    }
  }
}
