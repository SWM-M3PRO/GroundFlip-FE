import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import 'community_info_screen.dart';

class NoCommunityScreen extends StatelessWidget {
  const NoCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: AppColors.background,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "가입한 그룹이 없습니다.",
                style: TextStyles.fs28w800cTextPrimary,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "원하는 그룹을 검색해서 가입해보세요!",
                style: TextStyles.fs17w400cTextSecondary,
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                onTap: () {
                  Get.to(CommunityInfoScreen(groupId: 20));
                },
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primary,
                  ),
                  height: 60,
                  width: 200,
                  child: Center(
                    child: Text(
                      "그룹 검색",
                      style: TextStyles.fs17w600cTextBlack,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
