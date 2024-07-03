import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/android_walking_controller.dart';

class AndroidStepStats extends StatelessWidget {
  const AndroidStepStats({super.key});

  @override
  Widget build(BuildContext context) {
    var androidWalkingController = Get.put(AndroidWalkingController());
    return Obx(
          () => Column(
        children: [
          Text(
            '${androidWalkingController.currentSteps.value} 걸음',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              '${androidWalkingController.getCurrentCalorie()} kcal | ${androidWalkingController.getCurrentTravelDistance()}km',
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
