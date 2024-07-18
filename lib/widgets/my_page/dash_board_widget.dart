import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/my_page_controller.dart';
import '../../controllers/walking_controller.dart';

class DashBoardWidget extends StatelessWidget {
  final String textValue;
  final String iconImageUrl;
  final RxInt countValue;

  DashBoardWidget({
    super.key,
    required this.textValue,
    required this.iconImageUrl,
    required this.countValue,
  });

  final MyPageController myPageController = Get.find<MyPageController>();
  final WalkingController walkingController = Get.find<WalkingController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(textValue),
          Image.asset(
            'assets/$iconImageUrl',
            width: 40,
            height: 40,
          ),
          Obx(() => Text('${countValue.value}')),
        ],
      ),
    );
  }
}
