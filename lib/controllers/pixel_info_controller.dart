import 'package:get/get.dart';

import '../models/individual_mode_pixel_info.dart';
import '../service/pixel_service.dart';

class PixelInfoController extends GetxController {
  final PixelService pixelService = PixelService();

  getIndividualModePixelInfo(int pixelId) async {
    IndividualModePixelInfo individualModePixelInfo =
        await pixelService.getIndividualModePixelInfo(pixelId: pixelId);
    return individualModePixelInfo;
  }
}
