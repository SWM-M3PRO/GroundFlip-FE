import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/policy_controller.dart';

class PolicyAllCheck extends StatelessWidget {
  const PolicyAllCheck({super.key});

  @override
  Widget build(BuildContext context) {
    PolicyController policyController = Get.find<PolicyController>();

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        policyController.allPolicyCheck();
      },
      child: Obx(
        () => Container(
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: policyController.allPolicyChecked.value == 0
                ? AppColors.boxColor
                : AppColors.Third,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Icon(
                Icons.check_circle_rounded,
                color: policyController.allPolicyChecked.value == 0
                    ? Colors.white
                    : AppColors.primary,
                size: 30,
              ),
              SizedBox(
                width: 13,
              ),
              Text(
                '약관 전체 동의',
                style: TextStyle(
                  color: policyController.allPolicyChecked.value == 0
                      ? Colors.white
                      : AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
