import 'dart:math';

import 'package:location/location.dart';

import '../utils/location_history.dart';
import '../utils/location_speed_data.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  final Location location = Location();
  LocationData? currentLocation;
  LocationHistory locationHistory = LocationHistory();

  LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  updateCurrentLocation(LocationData locationData) {
    currentLocation = locationData;
    LocationData previousLocation =
        locationHistory.getCurrentLocation().locationData;
    double calculatesSpeed = calculateSpeed(previousLocation, locationData);
    locationHistory.add(LocationSpeedData(locationData, calculatesSpeed));
  }

  initCurrentLocation() async {
    LocationData locationData = await location.getLocation();
    currentLocation = locationData;
    locationHistory.add(
      LocationSpeedData(
        locationData,
        locationData.speed ?? 0,
      ),
    );
  }

  getCurrentSpeed() {
    return locationHistory.getCurrentLocationSpeed();
  }

  Future<void> enableBackgroundLocation() async {
    await location.changeNotificationOptions(
      title: '땅 따먹기 중!',
      subtitle: '백그라운드 작동 중입니다.',
      iconName: 'drawable/background_app_icon',
    );
    location.enableBackgroundMode(enable: true);
  }

  void disableBackgroundLocation() {
    location.enableBackgroundMode(enable: false);
  }

  calculateSpeed(LocationData previousLocation, LocationData currentLocation) {
    final timeInSeconds =
        (currentLocation.time! - previousLocation.time!) / 1000;
    final distanceInMeters = calculateDistance(
      previousLocation.latitude!,
      previousLocation.longitude!,
      currentLocation.latitude!,
      currentLocation.longitude!,
    );
    final speedInMps = distanceInMeters / timeInSeconds;
    final speedInKmH = speedInMps * 3.6;
    return speedInKmH;
  }

  double calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    const double earthRadius = 6371000;

    final double dLat = degreesToRadians(endLat - startLat);
    final double dLng = degreesToRadians(endLng - startLng);

    final double a = (sin(dLat / 2) * sin(dLat / 2)) +
        (cos(degreesToRadians(startLat)) *
            cos(degreesToRadians(endLat)) *
            sin(dLng / 2) *
            sin(dLng / 2));

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double degreesToRadians(double degrees) {
    return degrees * (3.141592653589793 / 180);
  }
}
