import 'package:get/get.dart';

import '../service/auth_service.dart';

class SettingController extends GetxController {
  final AuthService authService = AuthService();

  logout() async {
    await authService.logout();
    Get.offAllNamed('/login');
  }
}
