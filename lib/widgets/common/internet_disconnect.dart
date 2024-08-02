import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';

class InternetDisconnect extends StatelessWidget {
  const InternetDisconnect({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "인터넷에 연결해주세요!",
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
                '확인',
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 17
                ),
              ),
              onPressed: () async {
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
