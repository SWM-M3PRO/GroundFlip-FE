import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class SignoutBottomSheet extends StatelessWidget {
  final String name;
  final String profileImageUrl;
  final Function onTap;

  // final CommunityController communityController = Get.find<>();

  const SignoutBottomSheet(
      {super.key,
      required this.name,
      required this.profileImageUrl,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: AppColors.backgroundSecondary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            children: [
              Text(
                '가입한 그룹에서',
                style: TextStyles.fs28w700cTextPrimary,
              ),
              Text(
                '탈퇴하시겠습니까?',
                style: TextStyles.fs28w700cTextPrimary,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '함께한 기록들은 복구되지 않습니다',
                style: TextStyles.fs17w400cTextSecondary,
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/crying.png',
                width: 120,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: AppColors.backgroundThird,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/crying.png',
                        width: 48,
                      ),
                      SizedBox(width: 20),
                      Text(
                        name,
                        style: TextStyles.fs20w600cTextPrimary,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: AppColors.backgroundThird,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Center(
                            child: Text(
                              '취소',
                              style: TextStyles.fs17w700cTextPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        onTap();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: AppColors.accent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Center(
                            child: Text(
                              '탈퇴',
                              style: TextStyles.fs17w700cTextBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
