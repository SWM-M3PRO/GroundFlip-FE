import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/text_styles.dart';
import '../../controllers/achievement_controller.dart';

class AchievementListElement extends StatelessWidget {
  final int achievementId;
  final String badgeUrl;
  final String achievementName;
  final DateTime? obtainedDate;
  final bool isClickable;
  final AchievementController controller = Get.find<AchievementController>();

  AchievementListElement({
    super.key,
    required this.achievementId,
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
          controller.moveToAchievementInfoScreen(achievementId);
        },
        child: getElement(),
      );
    } else {
      return getElement();
    }
  }
}
