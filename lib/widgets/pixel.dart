import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/bottom_sheet_controller.dart';
import '../controllers/map_controller.dart';
import '../controllers/pixel_info_controller.dart';
import '../models/individual_history_pixel.dart';
import '../models/individual_history_pixel_info.dart';
import '../models/individual_mode_pixel.dart';
import '../models/individual_mode_pixel_info.dart';
import '../utils/user_manager.dart';

class Pixel extends Polygon {
  static const double latPerPixel = 0.000724;
  static const double lonPerPixel = 0.000909;
  static const double defaultStrokeWidthToLatitude = 0.00000905;
  static const double defaultStrokeWidthToLongitude = 0.0000113625;

  static const int defaultStrokeWidth = 2;
  static const double defaultZoomLevel = 16.0;

  final int x;
  final int y;
  final int pixelId;
  static final PixelInfoController pixelInfoController =
      Get.find<PixelInfoController>();

  Pixel({
    required this.x,
    required this.y,
    required this.pixelId,
    required void Function(int pixelId) customOnTap,
    required String polygonId,
    super.points,
    super.geodesic,
    super.visible,
    super.fillColor = const Color(0x00000000),
    super.strokeColor = const Color(0x00000000),
    super.strokeWidth = 0,
    List<PatternItem> patterns = const <PatternItem>[],
    super.consumeTapEvents = true,
    super.zIndex = 0,
  }) : super(
          polygonId: PolygonId(polygonId),
          onTap: () => customOnTap(pixelId),
        );

  static Pixel createEmptyPixel() {
    return Pixel(
      x: 0,
      y: 0,
      pixelId: 1,
      points: List<LatLng>.from({LatLng(0.0, 0.0)}),
      customOnTap: (int pixelId) {},
      polygonId: '1',
    );
  }

  static Pixel clonePixel(Pixel pixel) {
    return Pixel(
      x: pixel.x,
      y: pixel.y,
      pixelId: pixel.pixelId,
      customOnTap: (int pixelId) =>
          (pixel.onTap != null) ? (pixel.onTap!)() : {},
      polygonId: pixel.polygonId.value,
      points: List<LatLng>.from(pixel.points),
      geodesic: pixel.geodesic,
      visible: pixel.visible,
      fillColor: pixel.fillColor,
      strokeColor: pixel.strokeColor,
      strokeWidth: pixel.strokeWidth,
      consumeTapEvents: pixel.consumeTapEvents,
    );
  }

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
      strokeWidth: defaultStrokeWidth,
      customOnTap: (int pixelId) async {
        FirebaseAnalytics.instance
            .logEvent(name: "individual_mode_pixel_click");

        Get.find<MapController>().changePixelToOnTabState(pixelId);

        IndividualModePixelInfo pixelInfo =
            await Get.find<PixelInfoController>()
                .getIndividualModePixelInfo(pixelId);
        Get.find<BottomSheetController>()
            .showIndividualModePixelInfo(pixelInfo, pixelId);
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
      strokeWidth: defaultStrokeWidth,
      customOnTap: (int pixelId) async {
        FirebaseAnalytics.instance.logEvent(name: "history_pixel_click");

        Get.find<MapController>().changePixelToOnTabState(pixelId);

        IndividualHistoryPixelInfo pixelInfo =
            await Get.find<PixelInfoController>().getIndividualHistoryPixelInfo(
          pixelId,
          UserManager().getUserId()!,
        );
        Get.find<BottomSheetController>()
            .showIndividualHistoryPixelInfo(pixelInfo, pixelId);
      },
    );
  }

  static List<LatLng> _getRectangleFromLatLng({required LatLng topLeftPoint}) {
    double currentZoomLevel =
        Get.find<MapController>().currentCameraPosition.zoom;

    num zoomScale = (16.0 - currentZoomLevel) >= 0
        ? pow(2, (defaultZoomLevel - currentZoomLevel))
        : 1;

    double strokeWidthToLatitude = defaultStrokeWidthToLatitude * zoomScale;
    double strokeWidthToLongitude = defaultStrokeWidthToLongitude * zoomScale;

    return List<LatLng>.of({
      LatLng(topLeftPoint.latitude - strokeWidthToLatitude,
          topLeftPoint.longitude + strokeWidthToLongitude),
      LatLng(topLeftPoint.latitude - strokeWidthToLatitude,
          topLeftPoint.longitude + lonPerPixel - strokeWidthToLongitude),
      LatLng(
        topLeftPoint.latitude - latPerPixel + strokeWidthToLatitude,
        topLeftPoint.longitude + lonPerPixel - strokeWidthToLongitude,
      ),
      LatLng(topLeftPoint.latitude - latPerPixel + strokeWidthToLatitude,
          topLeftPoint.longitude + strokeWidthToLongitude),
    });
  }

  static Pixel createOnTabStatePixel(Pixel pixel) {
    return Pixel(
      x: pixel.x,
      y: pixel.y,
      pixelId: pixel.pixelId,
      polygonId: pixel.pixelId.toString(),
      points: pixel.points,
      fillColor: Colors.white.withOpacity(0.3),
      strokeColor: Colors.white,
      strokeWidth: defaultStrokeWidth,
      customOnTap: (pixelId) {},
      zIndex: 1,
    );
  }

  static bool isEmptyPixel(Pixel pixel) {
    return pixel.pixelId == 0;
  }
}
