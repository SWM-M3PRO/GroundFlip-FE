import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class MyPlaceButtonIcon extends StatelessWidget {
  final IconData icon;
  const MyPlaceButtonIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.backgroundSecondary
      ),
      child: Icon(
        icon,
        size: 20,
        color: AppColors.buttonColor,
      ),
    );
  }
}
