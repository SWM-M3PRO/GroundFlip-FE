import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../enums/pixel_mode.dart';
import '../models/individual_history_pixel.dart';
import '../models/individual_mode_pixel.dart';
import '../models/user_pixel_count.dart';
import '../service/pixel_service.dart';
import '../service/user_service.dart';
import '../utils/user_manager.dart';
import '../widgets/pixel.dart';

class MapController extends GetxController {
  final PixelService pixelService = PixelService();
  final UserService userService = UserService();

  static const String darkMapStylePath =
      'assets/map_style/dark_map_style_with_landmarks.txt';
  static const String userMarkerId = 'USER';
  static const double maxZoomOutLevel = 14.0;
  static const double latPerPixel = 0.000724;
  static const double lonPerPixel = 0.000909;

  final Location location = Location();
  late final String mapStyle;

  GoogleMapController? googleMapController;
  late LocationData currentLocation;
  late CameraPosition currentCameraPosition;
  late Map<String, int> latestPixel;

  Rx<PixelMode> currentPixelMode = PixelMode.individualHistory.obs;
  RxList<Pixel> pixels = <Pixel>[].obs;
  RxList<Marker> markers = <Marker>[].obs;
  RxBool isLoading = true.obs;
  final RxInt selectedType = 0.obs;
  final RxInt currentPixelCount = 0.obs;
  final RxInt accumulatePixelCount = 0.obs;

  Timer? _cameraIdleTimer;

  @override
  void onInit() async {
    super.onInit();
    await _loadMapStyle();
    await initCurrentLocation();
    _updateLatestPixel();
    await updateCurrentPixel();
    await occupyPixel();
    updatePixels();
    _createUserMarker();
    _trackUserLocation();
    _trackPixels();
  }

  updateCurrentPixel() async {
    UserPixelCount pixelCount = await userService.getUserPixelCount();
    currentPixelCount.value = pixelCount.currentPixelCount!;
    accumulatePixelCount.value = pixelCount.accumulatePixelCount!;
  }

  getSelectedType() {
    return selectedType.value;
  }

  void onCameraIdle() {
    _cameraIdleTimer = Timer(Duration(milliseconds: 300), updatePixels);
  }

  void updateCameraPosition(CameraPosition newCameraPosition) async {
    currentCameraPosition = newCameraPosition;
    _cameraIdleTimer?.cancel();
  }

  focusOnCurrentLocation() {
    currentCameraPosition = CameraPosition(
      target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
      zoom: 16.0,
    );
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(currentCameraPosition),
    );
  }

  void _trackUserLocation() {
    location.onLocationChanged.listen((newLocation) async {
      currentLocation = newLocation;
      if (isPixelChanged()) {
        _updateLatestPixel();
        await occupyPixel();
      }
      _updateMarkerPosition(newLocation, userMarkerId);
      focusOnCurrentLocation();
    });
  }

  Future<void> initCurrentLocation() async {
    try {
      currentLocation = await location.getLocation();
      currentCameraPosition = CameraPosition(
        target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        zoom: 16.0,
      );
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
    _addMarker(
      LatLng(currentLocation.latitude!, currentLocation.longitude!),
      userMarkerId,
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
    mapStyle = await rootBundle.loadString(darkMapStylePath);
  }

  void _updateMarkerPosition(LocationData newLocation, String markerId) {
    markers.removeWhere((marker) => marker.markerId.value == markerId);
    _addMarker(LatLng(newLocation.latitude!, newLocation.longitude!), markerId);
  }

  Future<void> _updateIndividualHistoryPixels(int radius) async {
    List<IndividualHistoryPixel> individualHistoryPixels =
        await pixelService.getIndividualHistoryPixels(
      currentLatitude: currentCameraPosition.target.latitude,
      currentLongitude: currentCameraPosition.target.longitude,
      radius: radius,
      userId: UserManager().getUserId()!,
    );

    pixels.assignAll([
      for (var pixel in individualHistoryPixels)
        Pixel.fromIndividualHistoryPixel(pixel: pixel),
    ]);
  }

  Future<void> _updateIndividualModePixel(int radius) async {
    List<IndividualModePixel> individualModePixels =
        await pixelService.getIndividualModePixels(
      currentLatitude: currentCameraPosition.target.latitude,
      currentLongitude: currentCameraPosition.target.longitude,
      radius: radius,
    );

    pixels.assignAll([
      for (var pixel in individualModePixels)
        Pixel.fromIndividualModePixel(
          pixel: pixel,
          isMyPixel: (pixel.userId == UserManager().getUserId()),
        ),
    ]);
  }

  void _trackPixels() {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      updatePixels();
    });
  }

  void updatePixels() async {
    if (_isMapOverZoomedOut()) {
      pixels.value = [];
      return;
    }

    int radius = await _getCurrentRadiusOfMap();
    switch (currentPixelMode.value) {
      case PixelMode.individualMode:
        _updateIndividualModePixel(radius);
        break;
      case PixelMode.individualHistory:
        _updateIndividualHistoryPixels(radius);
        break;
      case PixelMode.groupMode:
        break;
    }
  }

  bool _isMapOverZoomedOut() => currentCameraPosition.zoom < maxZoomOutLevel;

  Future<void> occupyPixel() async {
    await pixelService.occupyPixel(
      userId: UserManager().getUserId()!,
      currentLatitude: currentLocation.latitude!,
      currentLongitude: currentLocation.longitude!,
    );
    updatePixels();
    await updateCurrentPixel();
  }

  isPixelChanged() {
    Map<String, int> currentPixel =
        pixelService.computeRelativeCoordinateByCoordinate(
      currentLocation.latitude!,
      currentLocation.longitude!,
    );
    return latestPixel['x'] != currentPixel['x'] ||
        latestPixel['y'] != currentPixel['y'];
  }

  void changePixelMode(int type) {
    selectedType.value = type;
    currentPixelMode.value = PixelMode.fromInt(type);
    updatePixels();
  }

  updateSelectedType(int type) {
    selectedType.value = type;
  }

  Future<int> _getCurrentRadiusOfMap() async {
    LatLngBounds visibleRegion = await googleMapController!.getVisibleRegion();

    final LatLng topLeft = LatLng(
      visibleRegion.northeast.latitude,
      visibleRegion.southwest.longitude,
    );
    final LatLng bottomRight = LatLng(
      visibleRegion.southwest.latitude,
      visibleRegion.northeast.longitude,
    );

    return (_calculateDistance(topLeft, bottomRight) / 2).round();
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371000;

    final double dLat = _toRadians(end.latitude - start.latitude);
    final double dLng = _toRadians(end.longitude - start.longitude);

    final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(start.latitude)) *
            math.cos(_toRadians(end.latitude)) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);

    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * math.pi / 180;
  }

  getPixelCount() {
    if (currentPixelMode.value == PixelMode.individualHistory) {
      return accumulatePixelCount.value;
    } else {
      return currentPixelCount.value;
    }
  }
}
