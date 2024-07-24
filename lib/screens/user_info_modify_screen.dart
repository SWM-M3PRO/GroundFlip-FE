import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../controllers/user_info_controller.dart';

class UserInfoModifyScreen extends StatelessWidget {
  const UserInfoModifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserInfoController controller = Get.put(UserInfoController());
    const int lowBoundYear = 1900;
    const int upperBoundYear = 2024;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            '프로필 수정',
            style: TextStyle(
              color: AppColors.textPrimary,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Obx(
            () {
              if (!controller.isUserInfoInit.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [],
              );
            },
          ),
        ),
      ),
    );
  }
}
