import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/text_styles.dart';

class Alert extends StatelessWidget {
  final String title;
  String? content;
  final String buttonText;

  Alert(
      {super.key, required this.title, required this.buttonText, this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      content: content == null
          ? null
          : Text(
              content ?? "",
              style: TextStyles.fs17w400cTextSecondary,
            ),
      actions: [
        TextButton(
          child: Text(
            buttonText,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 17,
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: AppColors.boxColor,
    );
  }
}
