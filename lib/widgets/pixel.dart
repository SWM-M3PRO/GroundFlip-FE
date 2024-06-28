import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Pixel extends Polygon {
  final int x;
  final int y;
  final int pixelId;

  Pixel({
    required this.x,
    required this.y,
    required this.pixelId,
    required String polygonId,
    super.points,
    super.geodesic,
    super.visible,
    super.fillColor = const Color(0x00000000),
    super.strokeColor = const Color(0x00000000),
    super.strokeWidth = 0,
    List<PatternItem> patterns = const <PatternItem>[],
    super.consumeTapEvents,
    super.onTap,
  }) : super(
    polygonId: PolygonId(polygonId),
  );
}