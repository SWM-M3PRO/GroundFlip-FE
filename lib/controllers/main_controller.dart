import 'package:get/get.dart';

import '../service/fcm_service.dart';

class MainController extends GetxController {
  final FcmService fcmService = FcmService();

  @override
  void onInit() async {
    super.onInit();
    fcmService.registerFcmToken();
  }
}
