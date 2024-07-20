import 'package:flutter/material.dart';

import 'colors.dart';

class TextStyles {
  static TextStyle title1 = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  static TextStyle title2 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle body1 = TextStyle(
    color: AppColors.primary,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle rank = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );
}
