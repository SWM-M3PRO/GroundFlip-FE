import 'package:flutter/cupertino.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class PixelCountInfo extends StatelessWidget {
  const PixelCountInfo({
    super.key,
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: AppColors.backgroundSecondary),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/current_pixel_icon.png",
            width: 28,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "$count",
            style: TextStyles.fs17w600cTextPrimary,
          ),
        ],
      ),
    );
  }
}
