import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class GroupActionButton extends StatelessWidget {
  final bool isJoin;

  const GroupActionButton({super.key, required this.isJoin});

  @override
  Widget build(BuildContext context) {
    if (isJoin) {
      return InkWell(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        onTap: () {
          //Todo : 그룹 탈퇴 로직
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.boxColor,
          ),
          height: 60,
          width: 1000,
          child: Center(
            child: Text(
              "그룹 탈퇴",
              style: TextStyles.fs17w600cAccent,
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        onTap: () {
          //Todo : 그룹 가입 로직
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.primary,
          ),
          height: 60,
          width: 1000,
          child: Expanded(
            child: Center(
              child: Text(
                "그룹 가입 신청하기",
                style: TextStyles.fs17w600cTextBlack,
              ),
            ),
          ),
        ),
      );
    }
  }
}
