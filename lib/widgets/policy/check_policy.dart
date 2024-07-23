import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/app_colors.dart';
import '../../controllers/policy_controller.dart';

class CheckPolicy extends StatelessWidget {
  final String inputString;
  final int policyNum;

  CheckPolicy({
    super.key,
    required this.inputString,
    required this.policyNum,
  });

  @override
  Widget build(BuildContext context) {
    final PolicyController policyController = Get.find<PolicyController>();

    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.background,
      ),
      child: Row(
        children: [
          SizedBox(width: 28),
          Obx(
            () => IconButton(
              icon: Icon(
                Icons.check,
                color: policyController.checkPolicy[policyNum] == 0
                    ? AppColors.textPrimary
                    : AppColors.primary,
              ),
              onPressed: () {
                policyController.changeValue(policyNum);
                policyController.checkAllChecked();
              },
            ),
          ),
          SizedBox(width: 16),
          Text(
            inputString,
            style: TextStyle(
              fontSize: 17,
              color: AppColors.textPrimary,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textPrimary,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
