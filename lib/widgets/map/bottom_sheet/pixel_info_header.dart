import 'package:flutter/cupertino.dart';

import '../../../constants/text_styles.dart';
import '../../../enums/pixel_mode.dart';

class PixelInfoHeader extends StatelessWidget {
  const PixelInfoHeader({
    super.key,
    required this.address,
    required this.visitCount,
    required this.mode,
    required this.pixelId,
  });

  final int pixelId;
  final String? address;
  final int visitCount;
  final PixelMode mode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  pixelId.toRadixString(16).toUpperCase().padLeft(7, '0'),
                  style: TextStyles.fs24w900cTextPrimary,
                ),
                Text(
                  ' px',
                  style: TextStyles.fs14w500cPrimary,
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                address ?? "대한민국",
                style: TextStyles.fs17w400cTextSecondary,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ],
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
