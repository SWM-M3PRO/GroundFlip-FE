import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/user_info_controller.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    UserInfoController controller = Get.find<UserInfoController>();

    return Obx(
      () => Column(
        children: [
          CircleAvatar(
            radius: 80.0,
            backgroundImage: controller.profileImage.value != null
                ? FileImage(
              File(controller.profileImage.value!.path),
            ) as ImageProvider
                : controller.imageS3Url.value == ""
                ? AssetImage(
              'assets/images/default_profile_image.png',
            ) as ImageProvider
                : NetworkImage(controller.imageS3Url.value)
            as ImageProvider,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: controller.getImage,
                  child: Container(
                    height: 44,
                    width: 104,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: AppColors.boxColorThird,
                    ),
                    child: Center(
                      child: Text(
                        '이미지 변경',
                        style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                InkWell(
                  onTap: controller.deleteImage,
                  child: Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: AppColors.boxColorThird,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
