import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/app_colors.dart';
import '../service/location_service.dart';
import '../widgets/map/my_place_bottom_sheet.dart';
import 'bottom_sheet_controller.dart';

class MyPlaceController extends GetxController {
  final LocationService _locationService = LocationService();

  final BottomSheetController bottomSheetController =
  Get.find<BottomSheetController>();

  static const String darkMapStylePath =
      'assets/map_style/dark_map_style_with_landmarks.txt';

  late final String mapStyle;

  final box = GetStorage();

  GoogleMapController? googleMapController;

  late CameraPosition currentCameraPosition;

  RxList<Marker> markers = <Marker>[].obs;
  RxBool isLoading = true.obs;
  final RxDouble selectedLatitude = 37.503640.obs;
  final RxDouble selectedLongitude = 127.044829.obs;
  final RxString myPlaceName = "HOME".obs;
  final RxInt selectedPlace = 0.obs;

  bool isBottomSheetShowUp = false;


  @override
  void onInit() async {
    super.onInit();
    await _loadMapStyle();
    await initCurrentLocation();
  }

  onBottomBarHidden() {
    bottomSheetController.minimize();
  }

  void updateCoordinate(LatLng latLng) {
    selectedLatitude.value = latLng.latitude;
    selectedLongitude.value = latLng.longitude;
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

  Future<void> _loadMapStyle() async {
    mapStyle = await rootBundle.loadString(darkMapStylePath);
  }

  Future<void> writeMyPlaceOnLocalStorage(
      String place,
      double latitude,
      double longitude,
      ) async {
    await box.write(
      place,
      Point(latitude, longitude),
    );
    update();
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

  void changeSelectedPlace(int type) {
    selectedPlace.value = type;
    if (type == 0) {
      myPlaceName.value = "HOME";
    } else if (type == 1) {
      myPlaceName.value = "COMPANY";
    } else {
      myPlaceName.value = "ELSE";
    }
    bottomSheetController.minimize();
  }

  getSelectedPlace() {
    return selectedPlace.value;
  }
}
