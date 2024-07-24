import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/my_page_controller.dart';
import '../../screens/user_info_update_screen.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final MyPageController myPageController = Get.find<MyPageController>();
    return InkWell(
      onTap: () {
        Get.to(() => UserInfoUpdateScreen());
      },
      child: Ink(
        decoration: const BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () => Row(
              children: [
                ClipOval(
                  child: myPageController.getProfileImageURL() != null
                      ? Image.network(
                          myPageController.getProfileImageURL(),
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/default_profile_image.png',
                          width: 44,
                          height: 44,
                        ),
                ),
                SizedBox(
                  width: 30,
                ),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        myPageController.getCurrentUserNickname(),
                        style: TextStyles.fs20w600cTextPrimary,
                      ),
                      if (myPageController.getCurrentUserCommunityName() !=
                          null)
                        Text(
                          myPageController.getCurrentUserCommunityName()!,
                          style: TextStyles.fs14w400cTextSecondary,
                        ),
                    ],
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
