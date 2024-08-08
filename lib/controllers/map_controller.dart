import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../constants/app_colors.dart';
import '../enums/pixel_mode.dart';
import '../models/individual_history_pixel.dart';
import '../models/individual_mode_pixel.dart';
import '../models/user_pixel_count.dart';
import '../service/location_service.dart';
import '../service/pixel_service.dart';
import '../service/user_service.dart';
import '../utils/date_handler.dart';
import '../utils/user_manager.dart';
import '../widgets/map/filter_bottom_sheet.dart';
import '../widgets/map/my_place_bottom_sheet.dart';
import '../widgets/pixel.dart';
import 'bottom_sheet_controller.dart';

class MapController extends SuperController {
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

  Rx<PixelMode> currentPixelMode = PixelMode.individualMode.obs;
  String? currentPeriod;
  RxList<Pixel> pixels = <Pixel>[].obs;
  RxList<Marker> markers = <Marker>[].obs;
  RxBool isLoading = true.obs;
  final RxInt selectedMode = 1.obs;
  final RxInt selectedPeriod = 0.obs;
  final RxInt selectedPlace = 0.obs;
  final RxInt currentPixelCount = 0.obs;
  final RxInt accumulatePixelCount = 0.obs;
  final RxInt accumulatePixelCountPerPeriod = 0.obs;
  final RxDouble selectedLatitude = 37.503640.obs;
  final RxDouble selectedLongitude = 127.044829.obs;
  final RxString myPlaceName = "HOME".obs;
  RxDouble speed = 0.0.obs;
  RxBool isCameraTrackingUser = true.obs;

  RxBool myPlaceButtonVisible = false.obs;
  RxBool myPlaceisEmpty = true.obs;

  late Pixel lastOnTabPixel;
  bool isBottomSheetShowUp = false;

  Timer? _cameraIdleTimer;
  Timer? _updatePixelTimer;

  RxInt elapsedSeconds = 0.obs; // 경과 시간을 초 단위로 저장
  Timer? _timer;
  RxBool isRunning = false.obs;

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
    trackPixels();
    lastOnTabPixel = Pixel.createEmptyPixel();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {
    _updatePixelTimer?.cancel();
  }

  @override
  void onResumed() {
    trackPixels();
    setCameraOnCurrentLocation();
    isCameraTrackingUser = true.obs;
  }

  @override
  void onHidden() {}

  onBottomBarHidden() {
    bottomSheetController.minimize();
  }

  updateCurrentPixel() async {
    UserPixelCount pixelCount = await userService.getUserPixelCount(null);
    UserPixelCount pixelCountPeriod =
        await userService.getUserPixelCount(currentPeriod);
    currentPixelCount.value = pixelCount.currentPixelCount!;
    accumulatePixelCount.value = pixelCount.accumulatePixelCount!;
    accumulatePixelCountPerPeriod.value =
        pixelCountPeriod.accumulatePixelCount!;
  }

  getSelectedType() {
    return selectedMode.value;
  }

  getSelectedPeriod() {
    return selectedPeriod.value;
  }

  getSelectedPlace() {
    return selectedPlace.value;
  }

  void onCameraIdle() {
    if (!isBottomSheetShowUp) {
      _cameraIdleTimer = Timer(Duration(milliseconds: 300), updatePixels);
    }
  }

  void updateCameraPosition(CameraPosition newCameraPosition) async {
    currentCameraPosition = newCameraPosition;
    _cameraIdleTimer?.cancel();
  }

  setCameraOnCurrentLocation() {
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

  setCameraOnLocation(double latitude, double longitude) {
    currentCameraPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 16.0);
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(currentCameraPosition),
    );
  }

  void updateMarker(LatLng latLng) {
    markers.clear();
    markers.add(Marker(
      markerId: MarkerId('clicked_position'),
      position: latLng,
      infoWindow: InfoWindow(
        title: 'Clicked Position',
        snippet: 'Lat: ${latLng.latitude}, Lng: ${latLng.longitude}',
      ),
    ));
    selectedLatitude.value = latLng.latitude;
    selectedLongitude.value = latLng.longitude;
    print('1111 ${latLng.latitude}, ${latLng.longitude}');
  }

  void _trackUserLocation() {
    _locationService.location.onLocationChanged.listen((newLocation) async {
      _locationService.currentLocation = newLocation;

      if (isCameraTrackingUser.value) {
        setCameraOnCurrentLocation();
      }

      double currentSpeed = _convertSpeedToKmPerHour(newLocation.speed);
      speed.value = currentSpeed;
      if (isPixelChanged() && currentSpeed <= 10.5) {
        _updateLatestPixel();
        await occupyPixel();
      }
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

  Future<void> _loadMapStyle() async {
    mapStyle = await rootBundle.loadString(darkMapStylePath);
  }

  Future<void> _updateIndividualHistoryPixels(int radius) async {
    List<IndividualHistoryPixel> individualHistoryPixels =
        await pixelService.getIndividualHistoryPixels(
      currentLatitude: currentCameraPosition.target.latitude,
      currentLongitude: currentCameraPosition.target.longitude,
      radius: radius,
      userId: UserManager().getUserId()!,
      lookUpDate: currentPeriod,
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

  void trackPixels() {
    _updatePixelTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
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
    if (!isBottomSheetShowUp) {
      updatePixels();
    }
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
    selectedMode.value = type;
    currentPixelMode.value = PixelMode.fromInt(type);
    bottomSheetController.minimize();

    isBottomSheetShowUp = false;
    lastOnTabPixel = Pixel.createEmptyPixel();
    updatePixels();
    trackPixels();
  }

  void changePeriod(int type) {
    selectedPeriod.value = type;
    if (type == 0) {
      currentPeriod = null;
    } else if (type == 1) {
      currentPeriod = DateHandler.getStartOfThisWeekString();
    } else {
      currentPeriod = DateHandler.getNowString();
    }
    bottomSheetController.minimize();
    updatePixels();
  }

  void changePlace(int type) {
    selectedPlace.value = type;
    if (type == 0) {
      myPlaceName.value = "HOME";
    } else if (type == 1) {
      myPlaceName.value = "COMPANY";
    } else {
      myPlaceName.value = "ELSE";
    }
    bottomSheetController.minimize();
    updatePixels();
  }

  openFilterBottomSheet() {
    bottomSheetController.minimize();
    Get.bottomSheet(
      FilterBottomSheet(),
      backgroundColor: AppColors.backgroundSecondary,
      enterBottomSheetDuration: Duration(milliseconds: 100),
      exitBottomSheetDuration: Duration(milliseconds: 100),
    );
  }

  openMyPlaceBottomSheet() {
    bottomSheetController.minimize();
    Get.bottomSheet(
      MyPlaceBottomSheet(),
      backgroundColor: AppColors.backgroundSecondary,
      enterBottomSheetDuration: Duration(milliseconds: 100),
      exitBottomSheetDuration: Duration(milliseconds: 100),
    );
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
      return accumulatePixelCountPerPeriod.value;
    } else {
      return currentPixelCount.value;
    }
  }

  _convertSpeedToKmPerHour(double? speed) {
    if (speed == null) {
      return -1;
    } else {
      return speed * 3.6;
    }
  }

  void changePixelToOnTabState(int pixelId) async {
    if (!Pixel.isEmptyPixel(lastOnTabPixel)) {
      changePixelToNormalState();
    }

    lastOnTabPixel = Pixel.clonePixel(
      pixels.firstWhere((pixel) => pixel.pixelId == pixelId),
    );
    Pixel newPixel = Pixel.createOnTabStatePixel(lastOnTabPixel);
    pixels.removeWhere((pixel) => pixel.pixelId == pixelId);
    pixels.add(newPixel);

    isBottomSheetShowUp = true;

    _cameraIdleTimer?.cancel();
    _updatePixelTimer?.cancel();

    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            newPixel.points[0].latitude - Pixel.latPerPixel * 6,
            newPixel.points[0].longitude,
          ),
          zoom: 16.0,
        ),
      ),
    );
  }

  void changePixelToNormalState() {
    pixels.removeWhere((pixel) => pixel.pixelId == lastOnTabPixel.pixelId);
    pixels.add(lastOnTabPixel);
  }

  startExplore() {
    isRunning.value = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      elapsedSeconds.value++;
    });
    WakelockPlus.enable();
  }

  stopExplore() {
    isRunning.value = false;
    _timer!.cancel();
    elapsedSeconds.value = 0;
    WakelockPlus.disable();
  }
}
