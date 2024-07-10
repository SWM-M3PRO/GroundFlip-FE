import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/my_page_controller.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final MyPageController myPageController = Get.find<MyPageController>();
    return InkWell(
      onTap: () {
        // TODO: 개인정보 수정 페이지로 넘어가게 구현
      },
      child: Ink(
        decoration: const BoxDecoration(
          color: Color(0xFFD9D9D9),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () => Row(
              children: [
                ClipOval(
                  child: myPageController.getProfileImageURL() != null
                      ? Image.network(
                          myPageController.getProfileImageURL(),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/default_profile_image.png',
                          width: 80,
                          height: 80,
                        ),
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      myPageController.getCurrentUserNickname(),
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      myPageController.getCurrentUserCommunityName(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
