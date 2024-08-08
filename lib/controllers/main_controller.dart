import 'package:get/get.dart';

import '../service/fcm_service.dart';
import '../service/my_place_service.dart';

class MainController extends GetxController {
  final FcmService fcmService = FcmService();
  final MyPlaceService myPlaceService = MyPlaceService();

  @override
  void onInit() async {
    super.onInit();
    fcmService.registerFcmToken();
    myPlaceService.getMyPlaceInfo();
  }
}
