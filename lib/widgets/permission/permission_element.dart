import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class PermissionElement extends StatelessWidget {
  const PermissionElement({
    super.key,
    required this.iconPath,
    required this.permissionName,
    required this.permissionDescription,
  });

  final String iconPath;
  final String permissionName;
  final String permissionDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(16.0),
        ),
        height: 80.0,
        child: Row(
          children: [
            SizedBox(width: 16.0),
            Image.asset(
              iconPath,
              width: 40.0, // Adjust the size as needed
              height: 40.0, // Adjust the size as needed
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    permissionName,
                    style: TextStyles.fs17w600cTextPrimary,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    permissionDescription,
                    style: TextStyles.fs14w400cTextSecondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
