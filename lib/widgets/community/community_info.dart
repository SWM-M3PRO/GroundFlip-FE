import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class CommunityInfo extends StatelessWidget {
  final RxInt memberCount;
  final RxInt communityColor;
  final RxInt weeklyRanking;

  const CommunityInfo({
    super.key,
    required this.memberCount,
    required this.communityColor,
    required this.weeklyRanking,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommunityInfoElement(
          title: "멤버",
          content: Text(
            '${NumberFormat('###,###,###').format(memberCount.value)}명',
            style: TextStyles.fs17w700cTextPrimary,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        CommunityInfoElement(
          title: "그룹 색상",
          content: CommunityColor(
            color: communityColor.value,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        CommunityInfoElement(
          title: "주간 랭킹",
          content: Text(
            '${NumberFormat('###,###,###').format(weeklyRanking.value)}등',
            style: TextStyles.fs17w700cTextPrimary,
          ),
        ),
      ],
    );
  }
}

class CommunityInfoElement extends StatelessWidget {
  final String title;
  final Widget content;

  const CommunityInfoElement({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyles.fs14w400cTextSecondary,
              ),
              SizedBox(
                height: 5,
              ),
              content,
            ],
          ),
        ),
      ),
    );
  }
}

class CommunityColor extends StatelessWidget {
  final int color;

  const CommunityColor({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(color),
        border: Border.all(
          color: Colors.white, // 흰색 테두리
          width: 4.0, // 테두리 두께를 3으로 설정
        ),
      ),
      width: 24,
      height: 24,
    );
  }
}
