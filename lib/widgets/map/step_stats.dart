import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/my_page_controller.dart';

class StepStats extends StatelessWidget {
  const StepStats({super.key});

  @override
  Widget build(BuildContext context) {
    var walkController = Get.find<MyPageController>();
    return Obx(() => Column(
          children: [
            Text(
              '${walkController.getCurrentStep()} 걸음',
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
                '${walkController.getCurrentCalorie()} kcal | ${walkController.getCurrentTravelDistance()}km',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }
}
