import 'package:flutter/cupertino.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class PushPermissionItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool isAccent;
  final bool isLast;

  PushPermissionItem({
    required this.title,
    this.subTitle,
    this.isLast = false,
    this.isAccent = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: isLast
                ? BorderSide.none
                : BorderSide(
                    color: AppColors.backgroundThird,
                    width: 1.0,
                  ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color:
                          isAccent ? AppColors.accent : AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    subTitle!,
                    style: TextStyles.fs14w400cTextSecondary,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
            // Spacer(),
            CupertinoSwitch(value: true, onChanged: (bool value) {})
          ],
        ),
      ),
    );
  }
}
