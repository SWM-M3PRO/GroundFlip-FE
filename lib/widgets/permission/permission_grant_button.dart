import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/permission_request_controller.dart';

class PermissionGrantButton extends StatelessWidget {
  const PermissionGrantButton({super.key});

  @override
  Widget build(BuildContext context) {
    final PermissionRequestController permissionRequestController =
        Get.find<PermissionRequestController>();

    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 40.0,
      ),
      child: SizedBox(
        height: 60.0,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          onPressed: permissionRequestController.checkPermissions,
          child: Text(
            '권한 제공에 동의합니다',
            style: TextStyles.fs17w700cTextBlack,
          ),
        ),
      ),
    );
  }
}
