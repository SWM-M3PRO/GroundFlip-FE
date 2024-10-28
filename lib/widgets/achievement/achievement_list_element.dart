import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/text_styles.dart';
import '../../screens/achievement_info_screen.dart';

class AchievementListElement extends StatelessWidget {
  final String badgeUrl;
  final String achievementName;
  final DateTime? obtainedDate;
  final bool isClickable;

  const AchievementListElement({
    super.key,
    required this.badgeUrl,
    required this.achievementName,
    this.obtainedDate,
    this.isClickable = true,
  });

  Widget getElement() {
    return Column(
      children: [
        Image(
          image: CachedNetworkImageProvider(
            badgeUrl,
          ),
          width: 80,
          height: 80,
          color: Colors.black.withOpacity(
            obtainedDate != null ? 0 : 0.8,
          ),
          colorBlendMode: BlendMode.darken,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          achievementName,
          style: TextStyles.fs14w800cTextPrimary,
        ),
        if (obtainedDate != null)
          Text(
            DateFormat('yyyy.MM.dd').format(obtainedDate!),
            style: TextStyles.fs14w500cTextSecondary,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isClickable) {
      return GestureDetector(
        onTap: () {
          Get.to(
            AchievementInfoScreen(
              badgeUrl: "assets/images/badge/badge_4.png",
              achievementName: "경기도 정복왕",
              obtainedDate: DateTime.now(),
              achievementDetail: '경기도 땅의 10%를 방문하여 획득하세요.',
              currentValue: 50,
              completionGoal: 50,
              isRewardReceived: false,
            ),
          );
        },
        child: getElement(),
      );
    } else {
      return getElement();
    }
  }
}
