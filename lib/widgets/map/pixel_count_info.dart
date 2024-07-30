import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/map_controller.dart';
import '../../enums/pixel_mode.dart';

class PixelCountInfo extends StatelessWidget {
  const PixelCountInfo({
    super.key,
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.find<MapController>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.backgroundSecondary,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            return Image.asset(
              mapController.currentPixelMode.value ==
                      PixelMode.individualHistory
                  ? "assets/images/accumulate_pixel_icon.png"
                  : "assets/images/current_pixel_icon.png",
              width: 28,
            );
          }),
          SizedBox(
            width: 10,
          ),
          Obx(() {
            return Text(
              "${mapController.getPixelCount()}",
              style: TextStyles.fs17w600cTextPrimary,
            );
          }),
        ],
      ),
    );
  }
}
