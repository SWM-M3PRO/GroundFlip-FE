import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../screens/main_screen.dart';

class SignInCompleteBottomSheet extends StatelessWidget {
  const SignInCompleteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              Text(
                '그룹에 가입하였습니다!',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Image.asset(
                'assets/images/firecracker.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primary,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        '그룹 확인하기',
                        style: TextStyle(
                          fontSize: 17,
                          color: AppColors.textThird,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        )
      ],
    );
  }
}
