import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../models/individual_pixel.dart';
import '../service/pixel_service.dart';
import '../widgets/pixel.dart';

class MapController extends GetxController {
  final PixelService pixelService = PixelService();

  static const String darkMapStylePath = 'assets/map_style/dark_map_style.txt';
  static const String userMarkerId = 'USER';
  static const double latPerPixel = 0.000724;
  static const double lonPerPixel = 0.000909;
  static const int defaultUserId = 1;

  final Location location = Location();
  late final String mapStyle;
  Completer<GoogleMapController> completer = Completer();

  late LocationData currentLocation;
  late Map<String, int> latestPixel;

  RxList<Pixel> pixels = <Pixel>[].obs;
  RxList<Marker> markers = <Marker>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await _loadMapStyle();
    await updateCurrentLocation();
    _updateLatestPixel();
    await occupyPixel();
    await _updateIndividualPixel();
    _createUserMarker();
    _trackUserLocation();
    _trackPixels();
  }

  void _trackUserLocation() {
    location.onLocationChanged.listen((newLocation) async {
      currentLocation = newLocation;
      if (isPixelChanged()) {
        _updateLatestPixel();
        await occupyPixel();
      }
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

  void _updateLatestPixel() {
    latestPixel = pixelService.computeRelativeCoordinateByCoordinate(
      currentLocation.latitude!,
      currentLocation.longitude!,
    );
  }

  void _createUserMarker() {
    _addMarker(LatLng(currentLocation.latitude!, currentLocation.longitude!),
        userMarkerId,);
  }

  void _addMarker(LatLng position, String markerId) {
    final marker = Marker(
      markerId: MarkerId(markerId),
      position: position,
    );
    markers.add(marker);
  }

  Future<void> _loadMapStyle() async {
    mapStyle = await rootBundle.loadString(darkMapStylePath);
  }

  void _updateMarkerPosition(LocationData newLocation, String markerId) {
    markers.removeWhere((marker) => marker.markerId.value == markerId);
    _addMarker(LatLng(newLocation.latitude!, newLocation.longitude!), markerId);
  }

  Future<void> _updateIndividualPixel() async {
    List<IndividualPixel> individualPixelList =
        await pixelService.getIndividualPixels(
      currentLatitude: currentLocation.latitude!,
      currentLongitude: currentLocation.longitude!,
    );

    pixels = [
      for (var pixel in individualPixelList)
        Pixel(
          x: pixel.x,
          y: pixel.y,
          pixelId: pixel.pixelId,
          polygonId: pixel.pixelId.toString(),
          points: _getRectangleFromLatLng(
              topLeftPoint: LatLng(pixel.latitude, pixel.longitude),),
          fillColor: (pixel.userId == defaultUserId)
              ? Colors.blue.withOpacity(0.3)
              : Colors.red.withOpacity(0.3),
          strokeColor:
              (pixel.userId == defaultUserId) ? Colors.blue : Colors.red,
          strokeWidth: 1,
        ),
    ].obs;
  }

  List<LatLng> _getRectangleFromLatLng({required LatLng topLeftPoint}) {
    return List<LatLng>.of({
      LatLng(topLeftPoint.latitude, topLeftPoint.longitude),
      LatLng(topLeftPoint.latitude, topLeftPoint.longitude + lonPerPixel),
      LatLng(topLeftPoint.latitude - latPerPixel,
          topLeftPoint.longitude + lonPerPixel,),
      LatLng(topLeftPoint.latitude - latPerPixel, topLeftPoint.longitude),
    });
  }

  void _trackPixels() {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      _updateIndividualPixel();
    });
  }

  Future<void> occupyPixel() async {
    await pixelService.occupyPixel(
      userId: defaultUserId,
      currentLatitude: currentLocation.latitude!,
      currentLongitude: currentLocation.longitude!,
    );
    await _updateIndividualPixel();
  }

  isPixelChanged() {
    Map<String, int> currentPixel =
        pixelService.computeRelativeCoordinateByCoordinate(
            currentLocation.latitude!, currentLocation.longitude!,);
    return latestPixel['x'] != currentPixel['x'] ||
        latestPixel['y'] != currentPixel['y'];
  }
}
