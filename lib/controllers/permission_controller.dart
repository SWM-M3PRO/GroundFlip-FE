import 'package:get/get.dart';
import 'package:location/location.dart';

class PermissionController extends GetxController {
  var gpsEnabled = false.obs;
  Location location = Location();
  PermissionStatus gpsPermissionStatus = PermissionStatus.denied;

  @override
  void onInit() {
    super.onInit();
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    gpsPermissionStatus = await location.hasPermission();
    if (gpsPermissionStatus == PermissionStatus.denied) {
      await requestGpsPermission();
    }
  }

  Future<void> requestGpsPermission() async {
    gpsPermissionStatus = await location.requestPermission();
    if(gpsPermissionStatus == PermissionStatus.denied) {
      return;
    }
  }
}
