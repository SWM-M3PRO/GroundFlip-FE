import 'package:flutter/cupertino.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/text_styles.dart';

class NoRankerMessage extends StatelessWidget {
  const NoRankerMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundThird,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              "이 주차의 순위가 없습니다.",
              style: TextStyles.fs20w700cTextPrimary,
            ),
            Text(
              "다른 날짜를 선택해주세요!",
              style: TextStyles.fs17w700cPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
