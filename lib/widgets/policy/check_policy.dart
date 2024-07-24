import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../controllers/policy_controller.dart';

class CheckPolicy extends StatelessWidget {
  final String inputString;
  final int policyNum;

  String individualInfoPolicyUrl =
      'https://autumn-blouse-355.notion.site/e338b4179e5248eebe4c5827b347307b?pvs=4';
  String serviceUsePolicyUrl =
      'https://autumn-blouse-355.notion.site/58919803d41b40fba9ec0344625e94da?pvs=4';

  String placeServicePolicyUrl =
      'https://autumn-blouse-355.notion.site/ab3799e4818249daa3bfc32c7f44089d?pvs=4';

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
                color: policyController.checkPolicyList[policyNum] == 0
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
          GestureDetector(
            onTap: () {
              policyController.changeValue(policyNum);
              policyController.checkAllChecked();
            },
            child: Text(
              inputString,
              style: TextStyle(
                fontSize: 17,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              switch (policyNum) {
                case 0:
                  launchUrl(Uri.parse(individualInfoPolicyUrl));
                  break;
                case 1:
                  launchUrl(Uri.parse(serviceUsePolicyUrl));
                  break;
                case 2:
                  launchUrl(Uri.parse(placeServicePolicyUrl));
                  break;
              }
            },
            child: Container(
              width: 10,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textPrimary,
              size: 18,
            ),
            onPressed: () {
              switch (policyNum) {
                case 0:
                  launchUrl(Uri.parse(individualInfoPolicyUrl));
                  break;
                case 1:
                  launchUrl(Uri.parse(serviceUsePolicyUrl));
                  break;
                case 2:
                  launchUrl(Uri.parse(placeServicePolicyUrl));
                  break;
              }
            },
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
