import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/my_page_controller.dart';
import '../../screens/user_info_update_screen.dart';
import '../../utils/user_manager.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  String getEncodedUserId() {
    String base36 = UserManager().userId!.toRadixString(36).toUpperCase();
    return base36.padLeft(6, '0');
  }

  @override
  Widget build(BuildContext context) {
    final MyPageController myPageController = Get.find<MyPageController>();
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(16)),
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
                      ? Image(
                          image: CachedNetworkImageProvider(
                            myPageController.getProfileImageURL(),
                          ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            myPageController.getCurrentUserNickname(),
                            style: TextStyles.fs20w600cTextPrimary,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SelectableText(
                        '${getEncodedUserId()}',
                        style: TextStyles.fs14w600cTextSecondary,
                      ),
                      if (myPageController.getCurrentUserCommunityName() !=
                          null)
                        Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.group,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  myPageController
                                      .getCurrentUserCommunityName()!,
                                  style: TextStyles.fs14w500cPrimary,
                                ),
                              ],
                            ),
                          ],
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
