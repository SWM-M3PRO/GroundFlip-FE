import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/notification_controller.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final int category;
  final NotificationController controller = Get.find();

  CategoryButton({super.key, required this.label, required this.category});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isSelected = controller.selectedCategory.value == category;
      return GestureDetector(
        onTap: () => controller.updateCategory(category),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: isSelected ? Colors.white : AppColors.backgroundSecondary,
          ),
          child: Text(
            label,
            style: isSelected
                ? TextStyles.fs14w800cTextBlack
                : TextStyles.fs14w800cTextPrimary,
          ),
        ),
      );
    });
  }
}
