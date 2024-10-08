import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../controllers/policy_controller.dart';
import '../widgets/common/alert/marketing_push_permission_alert.dart';
import '../widgets/policy/check_policy.dart';
import '../widgets/policy/policy_all_check.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PolicyController policyController = Get.put(PolicyController());
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 90.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '서비스 사용을 위해 \n약관의 동의가 필요합니다',
                        style: TextStyles.fs28w800cTextPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              PolicyAllCheck(),
              SizedBox(height: 20),
              CheckPolicy(
                inputString: '개인정보 수집 및 이용 동의',
                policyNum: 0,
              ),
              SizedBox(height: 12),
              CheckPolicy(
                inputString: '서비스 이용 약관',
                policyNum: 1,
              ),
              SizedBox(height: 12),
              CheckPolicy(
                inputString: '위치 기반 서비스 이용 약관',
                policyNum: 2,
              ),
              SizedBox(height: 12),
              CheckPolicy(
                inputString: '만 14세 이상입니다',
                policyNum: 3,
              ),
              SizedBox(height: 20),
              // SizedBox(height: 40),
              Obx(
                () => InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    policyController.allPolicyChecked.value == 1
                        ? Get.dialog(MarketingPushPermissionAlert())
                        : null;
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: policyController.allPolicyChecked.value == 0
                          ? AppColors.boxColorSecond
                          : AppColors.primary,
                    ),
                    child: Center(
                      child: Text(
                        '다음',
                        style: TextStyles.fx17w700cTextThird,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
