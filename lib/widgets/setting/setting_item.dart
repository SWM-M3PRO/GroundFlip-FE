import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final VoidCallback? onTap;
  final bool isAccent;
  final bool isLast;

  SettingsItem(
      {required this.title,
      this.subTitle,
      this.onTap,
      this.isLast = false,
      super.key,
      this.isAccent = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isAccent ? AppColors.accent : AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            if (subTitle != null)
              Text(subTitle!, style: TextStyles.fs17w400cTextSecondary),
            SizedBox(width: 20),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textSecondary,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
