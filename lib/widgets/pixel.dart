import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/bottom_sheet_controller.dart';
import '../controllers/pixel_info_controller.dart';
import '../models/individual_history_pixel.dart';
import '../models/individual_history_pixel_info.dart';
import '../models/individual_mode_pixel.dart';
import '../models/individual_mode_pixel_info.dart';
import '../utils/user_manager.dart';

class Pixel extends Polygon {
  static const double latPerPixel = 0.000724;
  static const double lonPerPixel = 0.000909;

  final int x;
  final int y;
  final int pixelId;
  final PixelInfoController pixelInfoController =
      Get.find<PixelInfoController>();

  Pixel({
    required this.x,
    required this.y,
    required this.pixelId,
    required void Function(int pixelId) onTap,
    required String polygonId,
    super.points,
    super.geodesic,
    super.visible,
    super.fillColor = const Color(0x00000000),
    super.strokeColor = const Color(0x00000000),
    super.strokeWidth = 0,
    List<PatternItem> patterns = const <PatternItem>[],
    super.consumeTapEvents = true,
  }) : super(
          polygonId: PolygonId(polygonId),
          onTap: () => onTap(pixelId),
        );

  static Pixel fromIndividualModePixel({
    required IndividualModePixel pixel,
    required bool isMyPixel,
  }) {
    return Pixel(
      x: pixel.x,
      y: pixel.y,
      pixelId: pixel.pixelId,
      polygonId: pixel.pixelId.toString(),
      points: _getRectangleFromLatLng(
        topLeftPoint: LatLng(pixel.latitude, pixel.longitude),
      ),
      fillColor: isMyPixel
          ? Color(0xFF0DF69E)
              .withOpacity(0.3 + (Random().nextDouble() * (0.6 - 0.3)))
          : Colors.red.withOpacity(0.3 + (Random().nextDouble() * (0.6 - 0.3))),
      strokeColor: isMyPixel ? Color(0xFF0DF69E) : Colors.red,
      strokeWidth: 2,
      onTap: (int pixelId) async {
        IndividualModePixelInfo pixelInfo =
            await Get.find<PixelInfoController>()
                .getIndividualModePixelInfo(pixelId);
        Get.find<BottomSheetController>()
            .showIndividualModePixelInfo(pixelInfo);
      },
    );
  }

  static Pixel fromIndividualHistoryPixel({
    required IndividualHistoryPixel pixel,
  }) {
    return Pixel(
      x: pixel.x,
      y: pixel.y,
      pixelId: pixel.pixelId,
      polygonId: pixel.pixelId.toString(),
      points: _getRectangleFromLatLng(
        topLeftPoint: LatLng(pixel.latitude, pixel.longitude),
      ),
      fillColor: Color(0xFF0DF69E)
          .withOpacity(0.3 + (Random().nextDouble() * (0.6 - 0.3))),
      strokeColor: Color(0xFF0DF69E),
      strokeWidth: 2,
      onTap: (int pixelId) async {
        IndividualHistoryPixelInfo pixelInfo =
            await Get.find<PixelInfoController>().getIndividualHistoryPixelInfo(
          pixelId,
          UserManager().getUserId()!,
        );
        Get.find<BottomSheetController>()
            .showIndividualHistoryPixelInfo(pixelInfo);
      },
    );
  }

  static List<LatLng> _getRectangleFromLatLng({required LatLng topLeftPoint}) {
    return List<LatLng>.of({
      LatLng(topLeftPoint.latitude, topLeftPoint.longitude),
      LatLng(topLeftPoint.latitude, topLeftPoint.longitude + lonPerPixel),
      LatLng(
        topLeftPoint.latitude - latPerPixel,
        topLeftPoint.longitude + lonPerPixel,
      ),
      LatLng(topLeftPoint.latitude - latPerPixel, topLeftPoint.longitude),
    });
  }
}
