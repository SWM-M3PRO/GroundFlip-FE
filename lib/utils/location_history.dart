import 'location_speed_data.dart';

class LocationHistory {
  static const maxCount = 50;
  static const speedThreshold = 20;
  List<LocationSpeedData> locationHistory = [];
  int overThresholdCount = 0;

  add(LocationSpeedData location) {
    if (locationHistory.length == maxCount) {
      removeOldestHistory();
    }
    if (location.speed > speedThreshold) {
      overThresholdCount += 1;
    }
    locationHistory.add(location);
  }

  void removeOldestHistory() {
    if (locationHistory[0].speed > speedThreshold) {
      overThresholdCount -= 1;
    }
    locationHistory.removeAt(0);
  }

  LocationSpeedData getCurrentLocation() {
    return locationHistory.last;
  }

  double getCurrentLocationSpeed() {
    return locationHistory.last.speed;
  }

  isNotDriving() {
    return overThresholdCount <= 3;
  }
}
