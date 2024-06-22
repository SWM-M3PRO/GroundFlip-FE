import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../service/android_walk_interface.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final AndroidStepCounter AndroidStepController =
      Get.put(AndroidStepCounter());
    return Column(
        children: [
          Text('지도'),
          Obx(() => Text('${AndroidStepController.steps.value}'))
          ],
      );
  }
}
