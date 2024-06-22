import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  bool isLoading = false;
  Completer<GoogleMapController> completer = Completer();


}