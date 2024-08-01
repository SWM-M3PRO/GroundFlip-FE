import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/my_page_controller.dart';
import '../../controllers/walking_controller.dart';

class PixelDashBoardWidget extends StatelessWidget {
  final String textValue;
  final String iconImageUrl;
  final RxInt countValue;

  PixelDashBoardWidget({
    super.key,
    required this.textValue,
    required this.iconImageUrl,
    required this.countValue,
  });

  final MyPageController myPageController = Get.find<MyPageController>();
  final WalkingController walkingController = Get.find<WalkingController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textValue,
                    style: TextStyles.fs14w400cTextSecondary,
                  ),
                  Obx(
                    () => Text(
                      NumberFormat('###,###,###').format(countValue.value),
                      style: TextStyles.fs20w700cPrimary,
                    ),
                  ),
                ],
              ),
              Image.asset(
                iconImageUrl,
                width: 48,
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
