import 'package:flutter/cupertino.dart';

import '../../../constants/text_styles.dart';
import '../../../enums/pixel_mode.dart';

class PixelInfoHeader extends StatelessWidget {
  const PixelInfoHeader({
    super.key,
    required this.address,
    required this.visitCount,
    required this.mode,
  });

  final String? address;
  final int visitCount;
  final PixelMode mode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          address ?? "대한민국",
          style: TextStyles.fs24w900cTextPrimary,
        ),
        Spacer(),
        Text(
          createSubPixelInfo(),
          style: TextStyles.fs17w400cTextSecondary,
        ),
      ],
    );
  }

  createSubPixelInfo() {
    if (mode == PixelMode.individualHistory) {
      return "$visitCount번째 방문";
    } else if (mode == PixelMode.individualMode) {
      return "오늘 $visitCount명이 점령";
    }
  }
}
