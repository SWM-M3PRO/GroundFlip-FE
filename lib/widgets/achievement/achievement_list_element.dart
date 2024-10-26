import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../constants/text_styles.dart';

class AchievementListElement extends StatelessWidget {
  final String badgeUrl;
  final String achievementName;
  final DateTime obtainedDate;

  const AchievementListElement(
      {super.key,
      required this.badgeUrl,
      required this.achievementName,
      required this.obtainedDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          badgeUrl,
          width: 80,
          height: 80,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          achievementName,
          style: TextStyles.fs16w700cTextPrimary,
        ),
        Text(
          DateFormat('yyyy.MM.dd').format(obtainedDate),
          style: TextStyles.fs14w500cTextSecondary,
        )
      ],
    );
  }
}
