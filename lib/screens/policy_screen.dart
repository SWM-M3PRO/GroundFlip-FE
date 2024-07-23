import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ground_flip/screens/sign_up_screen.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../controllers/policy_controller.dart';
import '../widgets/policy/check_policy.dart';
import '../widgets/policy/next_button.dart';
import '../widgets/policy/policy_all_check.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PolicyController policyController = Get.put(PolicyController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SizedBox(height: 87),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '서비스 사용을 위해 \n약관의 동의가 필요합니다',
                    style: TextStyles.fs28w800cTextPrimary,
                  ),
                ),
                SizedBox(height: 350),
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
                SizedBox(height: 40),
                Obx(
                  () => InkWell(
                    onTap: () {
                      policyController.allPolicyChecked.value == 1
                          ? Get.to(SignUpScreen())
                          : null;
                    },
                    child: Container(
                      height: 65,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}