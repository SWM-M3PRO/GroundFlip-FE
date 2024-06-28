import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../service/individual_pixel_service.dart';

class MapController extends GetxController {
  final IndividualPixelService individualPixelService = IndividualPixelService();

  static const String darkMapStylePath = 'assets/map_style/dark_map_style.txt';
  static const String userMarkerId = 'USER';

  final Location location = Location();
  late final String darkMapStyle;
  Completer<GoogleMapController> completer = Completer();

  late LocationData currentLocation;

  RxList<Marker> markers = <Marker>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await _loadMapStyle();
    await updateCurrentLocation();
    _createUserMarker();
    _trackUserLocation();
    print('-------------http 요청-----------');
    await individualPixelService.getIndividualPixels(currentLatitude: currentLocation.latitude!, currentLongitude: currentLocation.longitude!);
    print('-------------http 요청-----------');
  }

  void _trackUserLocation() {
    location.onLocationChanged.listen((newLocation) {
      currentLocation = newLocation;
      _updateMarkerPosition(newLocation, userMarkerId);
    });
  }

  Future<void> updateCurrentLocation() async {
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      throw Error();
    } finally {
      isLoading.value = false;
    }
  }

  void _createUserMarker() {
    _addMarker(LatLng(currentLocation.latitude!, currentLocation.longitude!), userMarkerId);
  }

  void _addMarker(LatLng position, String markerId) {
    final marker = Marker(
      markerId: MarkerId(markerId),
      position: position,
    );
    markers.add(marker);
  }

  Future<void> _loadMapStyle() async {
    darkMapStyle = await rootBundle.loadString(darkMapStylePath);
  }

  void _updateMarkerPosition(LocationData newLocation, String markerId) {
    markers.removeWhere((marker) => marker.markerId.value == markerId);
    _addMarker(LatLng(newLocation.latitude!, newLocation.longitude!), markerId);
  }


}
