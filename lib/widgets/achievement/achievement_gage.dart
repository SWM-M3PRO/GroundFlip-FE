import 'package:flutter/cupertino.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class AchievementGage extends StatelessWidget {
  final int currentValue;
  final int completionGoal;

  const AchievementGage({
    super.key,
    required this.currentValue,
    required this.completionGoal,
  });

  @override
  Widget build(BuildContext context) {
    double progressRatio = (currentValue / completionGoal).clamp(0.0, 1.0);
    double progressWidth =
        (MediaQuery.of(context).size.width - 80) * progressRatio;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentValue.toString(),
              style: TextStyles.fs17w700cPrimary,
            ),
            Text(
              " / ",
              style: TextStyles.fs17w600cTextPrimary,
            ),
            Text(
              completionGoal.toString(),
              style: TextStyles.fs17w600cTextPrimary,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Stack(
          children: [
            Container(
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.backgroundThird,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            Container(
              height: 16,
              width: progressWidth,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryGradient, AppColors.primary],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
