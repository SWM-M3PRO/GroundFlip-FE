import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../constants/app_colors.dart';
import '../enums/pixel_mode.dart';
import '../models/community_mode_pixel.dart';
import '../models/individual_history_pixel.dart';
import '../models/individual_mode_pixel.dart';
import '../models/user_pixel_count.dart';
import '../service/community_service.dart';
import '../service/location_service.dart';
import '../service/pixel_service.dart';
import '../service/user_service.dart';
import '../utils/date_handler.dart';
import '../utils/user_manager.dart';
import '../utils/walking_service.dart';
import '../utils/walking_service_factory.dart';
import '../widgets/map/filter_bottom_sheet.dart';
import '../widgets/pixel.dart';
import 'bottom_sheet_controller.dart';
import 'my_page_controller.dart';

class MapController extends SuperController {
  final PixelService pixelService = PixelService();
  final UserService userService = UserService();
  final CommunityService communityService = CommunityService();
  final LocationService _locationService = LocationService();
  final WalkingService walkingService =
      WalkingServiceFactory.getWalkingService();

  final BottomSheetController bottomSheetController =
      Get.find<BottomSheetController>();

  static const String darkMapStylePath =
      'assets/map_style/dark_map_style_with_landmarks.txt';
  static const String userMarkerId = 'USER';
  static const double maxZoomOutLevel = 13.0;
  static const double latPerPixel = 0.000724;
  static const double lonPerPixel = 0.000909;

  late final String mapStyle;

  GoogleMapController? googleMapController;

  final box = GetStorage();

  late CameraPosition currentCameraPosition;
  late Map<String, int> latestPixel;

  Rx<PixelMode> currentPixelMode = PixelMode.individualMode.obs;
  String? currentPeriod;
  RxList<Pixel> visiblePixels = <Pixel>[].obs;
  List<Pixel> pixelCache = [];
  RxList<Marker> markers = <Marker>[].obs;
  RxBool isLoading = true.obs;
  final RxInt selectedMode = 1.obs;
  final RxInt selectedPeriod = 0.obs;
  final RxInt currentPixelCount = 0.obs;
  final RxInt currentCommunityPixelCount = 0.obs;
  final RxInt accumulatePixelCount = 0.obs;
  final RxInt accumulatePixelCountPerPeriod = 0.obs;

  RxDouble speed = 0.0.obs;
  RxBool isCameraTrackingUser = true.obs;

  RxBool myPlaceButtonVisible = false.obs;

  late Pixel lastOnTabPixel;
  bool isBottomSheetShowUp = false;

  Timer? _cameraIdleTimer;
  Timer? _updatePixelTimer;

  RxInt elapsedSeconds = 0.obs; // 경과 시간을 초 단위로 저장
  Timer? _timer;
  RxBool isRunning = false.obs;

  LatLngBounds? lastUpdateLatLngBounds;

  @override
  void onInit() async {
    super.onInit();
    await _loadMapStyle();
    await initCurrentLocation();
    _updateLatestPixel();
    await updateCurrentPixel();
    await occupyPixel();
    lastUpdateLatLngBounds = LatLngBounds(northeast: LatLng(0, 0), southwest: LatLng(0, 0));
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
    currentCommunityPixelCount.value =
        await communityService.getCommunityPixelCount(
      Get.find<MyPageController>().currentUserInfo.value.communityId,
    );
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

  void updateCameraPosition(CameraPosition newCameraPosition) async {
    currentCameraPosition = newCameraPosition;
    _cameraIdleTimer?.cancel();
  }

  setCameraOnCurrentLocation() {
    isCameraTrackingUser = true.obs;

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
    currentCameraPosition = CameraPosition(
      target: LatLng(
        latitude,
        longitude,
      ),
      zoom: 16.0,
    );
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(currentCameraPosition),
    );

    isCameraTrackingUser = false.obs;
  }

  void _trackUserLocation() {
    _locationService.location.onLocationChanged.listen((newLocation) async {
      _locationService.updateCurrentLocation(newLocation);
      if (isCameraTrackingUser.value) {
        setCameraOnCurrentLocation();
      }
      speed.value = _locationService.getCurrentSpeed();
      if (isPixelChanged() && isWalking()) {
        _updateLatestPixel();
        await occupyPixel();
      }
    });
  }

  isWalking() {
    return walkingService.isWalking() &&
        _locationService.getCurrentSpeed() <= 25;
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

  Future<void> _fetchIndividualHistoryPixels(int radius) async {
    List<IndividualHistoryPixel> individualHistoryPixels =
        await pixelService.getIndividualHistoryPixels(
      currentLatitude: currentCameraPosition.target.latitude,
      currentLongitude: currentCameraPosition.target.longitude,
      radius: radius,
      userId: UserManager().getUserId()!,
      lookUpDate: currentPeriod,
    );

    pixelCache = [
      for (var pixel in individualHistoryPixels)
        Pixel.fromIndividualHistoryPixel(pixel: pixel),
    ];
  }

  Future<void> _fetchIndividualModePixel(int radius) async {
    List<IndividualModePixel> individualModePixels =
        await pixelService.getIndividualModePixels(
      currentLatitude: currentCameraPosition.target.latitude,
      currentLongitude: currentCameraPosition.target.longitude,
      radius: radius,
    );

    pixelCache = [
      for (var pixel in individualModePixels)
        Pixel.fromIndividualModePixel(
          pixel: pixel,
          isMyPixel: (pixel.userId == UserManager().getUserId()),
        ),
    ];
  }

  Future<void> _fetchCommunityModePixel(int radius) async {
    List<CommunityModePixel> communityModePixels =
        await pixelService.getCommunityModePixels(
      currentLatitude: currentCameraPosition.target.latitude,
      currentLongitude: currentCameraPosition.target.longitude,
      radius: radius,
    );

    pixelCache = [
      for (var pixel in communityModePixels)
        Pixel.fromCommunityModePixel(
          pixel: pixel,
        ),
    ];
  }

  void trackPixels() {
    _updatePixelTimer =
        Timer.periodic(const Duration(seconds: 10), (timer) async {
      UserManager().updateSecureStorage();
      updatePixels();
    });
  }

  void updatePixels() async {
    if (_isMapOverZoomedOut()) {
      visiblePixels.value = [];
      return;
    }

    LatLngBounds currentMapBounds = await googleMapController!.getVisibleRegion();

    if (isCurrentBoundsWithinExpandedBounds(currentMapBounds, lastUpdateLatLngBounds!)) {
      refreshRenderedPixel();
      return;
    }

    lastUpdateLatLngBounds = expandBounds(currentMapBounds, 3);

    int currentMapRadius = await _getCurrentRadiusOfMap();
    int radius = 3 * currentMapRadius;
    switch (currentPixelMode.value) {
      case PixelMode.individualMode:
        _fetchIndividualModePixel(radius);
        break;
      case PixelMode.individualHistory:
        _fetchIndividualHistoryPixels(radius);
        break;
      case PixelMode.groupMode:
        _fetchCommunityModePixel(radius);
        break;
    }
    refreshRenderedPixel();
    await updateCurrentPixel();
  }

  bool _isMapOverZoomedOut() => currentCameraPosition.zoom < maxZoomOutLevel;

  Future<void> occupyPixel() async {
    await pixelService.occupyPixel(
      userId: UserManager().getUserId()!,
      currentLatitude: _locationService.currentLocation!.latitude!,
      currentLongitude: _locationService.currentLocation!.longitude!,
      communityId:
          Get.find<MyPageController>().currentUserInfo.value.communityId,
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

  openFilterBottomSheet() {
    bottomSheetController.minimize();
    Get.bottomSheet(
      FilterBottomSheet(),
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
    } else if (currentPixelMode.value == PixelMode.individualMode) {
      return currentPixelCount.value;
    } else {
      return currentCommunityPixelCount.value;
    }
  }

  void changePixelToOnTabState(int pixelId) async {
    if (!Pixel.isEmptyPixel(lastOnTabPixel)) {
      changePixelToNormalState();
    }

    lastOnTabPixel = Pixel.clonePixel(
      visiblePixels.firstWhere((pixel) => pixel.pixelId == pixelId),
    );
    Pixel newPixel = Pixel.createOnTabStatePixel(lastOnTabPixel);
    visiblePixels.removeWhere((pixel) => pixel.pixelId == pixelId);
    visiblePixels.add(newPixel);

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
    visiblePixels.removeWhere((pixel) => pixel.pixelId == lastOnTabPixel.pixelId);
    visiblePixels.add(lastOnTabPixel);
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

  Future<void> deleteMyPlaceFromLocalStorage(String place) async {
    await box.remove(place);
  }

  LatLngBounds expandBounds(LatLngBounds bounds, double factor) {
    final latDiff = (bounds.northeast.latitude - bounds.southwest.latitude) * (factor - 1) / 2;
    final lngDiff = (bounds.northeast.longitude - bounds.southwest.longitude) * (factor - 1) / 2;

    final newNorthEast = LatLng(bounds.northeast.latitude + latDiff, bounds.northeast.longitude + lngDiff);
    final newSouthWest = LatLng(bounds.southwest.latitude - latDiff, bounds.southwest.longitude - lngDiff);

    return LatLngBounds(northeast: newNorthEast, southwest: newSouthWest);
  }

  bool isCurrentBoundsWithinExpandedBounds(LatLngBounds currentBounds,LatLngBounds expandedBounds) {
    return currentBounds.southwest.latitude >= expandedBounds.southwest.latitude &&
        currentBounds.northeast.latitude <= expandedBounds.northeast.latitude &&
        currentBounds.southwest.longitude >= expandedBounds.southwest.longitude &&
        currentBounds.northeast.longitude <= expandedBounds.northeast.longitude;
  }

  bool isPixelInCurrentBounds(Pixel pixel, LatLngBounds bounds) {
    return isLatLngInBounds(pixel.points[0], bounds);
  }

  bool isLatLngInBounds(LatLng latLng, LatLngBounds bounds) {
    return latLng.latitude >= bounds.southwest.latitude &&
        latLng.latitude <= bounds.northeast.latitude &&
        latLng.longitude >= bounds.southwest.longitude &&
        latLng.longitude <= bounds.northeast.longitude;
  }

  void refreshRenderedPixel() async {
    LatLngBounds currentBounds = await googleMapController!.getVisibleRegion();

    LatLngBounds expandedBounds = expandBounds(currentBounds, 1.5);
    visiblePixels.assignAll(
        pixelCache.where((pixel) => isPixelInCurrentBounds(pixel, expandedBounds)).toList(),
    );
  }

}
