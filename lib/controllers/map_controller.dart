import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  bool isLoading = false;
  Completer<GoogleMapController> completer = Completer();
  String? darkMapStyle;
  @override
  void onInit() {
    super.onInit();
    _loadMapStyle();
  }

  void _loadMapStyle() async {
    darkMapStyle = await rootBundle.loadString('assets/map_style/dark_map_style.txt');
  }
}