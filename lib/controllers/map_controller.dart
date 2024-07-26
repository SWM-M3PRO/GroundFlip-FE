import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../enums/pixel_mode.dart';
import '../models/individual_history_pixel.dart';
import '../models/individual_mode_pixel.dart';
import '../models/user_pixel_count.dart';
import '../service/location_service.dart';
import '../service/pixel_service.dart';
import '../service/user_service.dart';
import '../utils/user_manager.dart';
import '../widgets/pixel.dart';
import 'bottom_sheet_controller.dart';

class MapController extends GetxController {
  final PixelService pixelService = PixelService();
  final UserService userService = UserService();
  final LocationService _locationService = LocationService();

  final BottomSheetController bottomSheetController =
      Get.find<BottomSheetController>();

  static const String darkMapStylePath =
      'assets/map_style/dark_map_style_with_landmarks.txt';
  static const String userMarkerId = 'USER';
  static const double maxZoomOutLevel = 14.0;
  static const double latPerPixel = 0.000724;
  static const double lonPerPixel = 0.000909;

  late final String mapStyle;

  GoogleMapController? googleMapController;

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
    _trackUserLocation();
    _trackPixels();
  }

  onHidden() {
    bottomSheetController.minimize();
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
      target: LatLng(
        _locationService.currentLocation!.latitude!,
        _locationService.currentLocation!.longitude!,
      ),
      zoom: 16.0,
    );
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(currentCameraPosition),
    );
  }

  void _trackUserLocation() {
    _locationService.location.onLocationChanged.listen((newLocation) async {
      _locationService.currentLocation = newLocation;
      if (isPixelChanged()) {
        _updateLatestPixel();
        await occupyPixel();
      }
      _updateMarkerPosition(newLocation, userMarkerId);
    });
  }

  Future<void> initCurrentLocation() async {
    try {
      await LocationService().initCurrentLocation();
      currentCameraPosition = CameraPosition(
        target: LatLng(
          _locationService.currentLocation!.latitude!,
          _locationService.currentLocation!.longitude!,
        ),
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
      _locationService.currentLocation!.latitude!,
      _locationService.currentLocation!.longitude!,
    );
  }

  Future<void> _createUserMarker() async {
    final Uint8List userMarkerIcon = await getBytesFromAsset(
      'assets/images/current_location_marker.png',
      48,
    );

    _addMarker(
      LatLng(
        _locationService.currentLocation!.latitude!,
        _locationService.currentLocation!.longitude!,
      ),
      userMarkerId,
      BitmapDescriptor.bytes(userMarkerIcon),
    );
  }

  void _addMarker(
    LatLng position,
    String markerId,
    BitmapDescriptor icon,
  ) {
    final marker = Marker(
      markerId: MarkerId(markerId),
      position: position,
      icon: icon,
    );
    markers.add(marker);
  }

  Future<void> _loadMapStyle() async {
    mapStyle = await rootBundle.loadString(darkMapStylePath);
  }

  void _updateMarkerPosition(LocationData newLocation, String markerId) {
    Marker marker =
        markers.firstWhere((marker) => marker.markerId.value == markerId);

    markers.removeWhere((marker) => marker.markerId.value == markerId);
    _addMarker(
      LatLng(newLocation.latitude!, newLocation.longitude!),
      markerId,
      marker.icon,
    );
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
    Timer.periodic(const Duration(seconds: 10), (timer) {
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
    await updateCurrentPixel();
  }

  bool _isMapOverZoomedOut() => currentCameraPosition.zoom < maxZoomOutLevel;

  Future<void> occupyPixel() async {
    await pixelService.occupyPixel(
      userId: UserManager().getUserId()!,
      currentLatitude: _locationService.currentLocation!.latitude!,
      currentLongitude: _locationService.currentLocation!.longitude!,
    );
    updatePixels();
    await updateCurrentPixel();
  }

  isPixelChanged() {
    Map<String, int> currentPixel =
        pixelService.computeRelativeCoordinateByCoordinate(
      _locationService.currentLocation!.latitude!,
      _locationService.currentLocation!.longitude!,
    );
    return latestPixel['x'] != currentPixel['x'] ||
        latestPixel['y'] != currentPixel['y'];
  }

  void changePixelMode(int type) {
    selectedType.value = type;
    currentPixelMode.value = PixelMode.fromInt(type);
    bottomSheetController.minimize();
    updatePixels();
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

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
