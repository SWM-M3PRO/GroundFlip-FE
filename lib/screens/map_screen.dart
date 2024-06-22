import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../service/android_walk_interface.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final AndroidWalkInterface AndroidWalkController =
      Get.put(AndroidWalkInterface());
    return Column(
        children: [
          Text('지도'),
          Obx(() => Text('${AndroidWalkController.steps.value}'))
          ],
      );
  }
}
