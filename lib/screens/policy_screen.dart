import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SizedBox(height: 87),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '서비스 사용을 위해 \n약관의 동의가 필요합니다',
                    style: TextStyles.fs28w800cTextPrimary,
                  ),
                ),
                SizedBox(height: 200),
                Container(
                  height: 60,
                  color: AppColors.backgroundForth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
