import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';

class CommunityMemberScreen extends StatelessWidget {
  final String communityName;

  const CommunityMemberScreen({super.key, required this.communityName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          communityName,
          style: TextStyles.fs20w700cTextPrimary,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: AppColors.buttonColor,
          onPressed: () {
            Get.back();
          },
        ),
      ),
    );
  }
}
