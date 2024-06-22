import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  final Location location = Location();
  late final String darkMapStyle;
  Completer<GoogleMapController> completer = Completer();

  late LocationData currentLocation;

  RxSet<Marker> markers = <Marker>{}.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await _loadMapStyle();
    await getCurrentPosition();
    _addMarkerOnCurrentLatLng();
  }

  Future<void> getCurrentPosition() async {
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      throw Error();
    } finally {
      isLoading.value = false;
    }
  }

  void _addMarkerOnCurrentLatLng() {
    _addMarker(
      LatLng(currentLocation.latitude!, currentLocation.longitude!),
      "current_location",
    );
  }

  void _addMarker(LatLng position, String markerId) {
    final marker = Marker(
      markerId: MarkerId(markerId),
      position: position,
    );
    markers.add(marker);
  }

  Future<void> _loadMapStyle() async {
    darkMapStyle = await rootBundle.loadString('assets/map_style/dark_map_style.txt');
  }
}