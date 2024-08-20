import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';

class Alert extends StatelessWidget {
  final String text1;
  final String text2;
  Alert({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        text1,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: TextButton(
              child: Text(
                text2,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 17,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: AppColors.boxColor,
    );
  }
}
