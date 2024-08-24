import 'package:location/location.dart';

class LocationHistory {
  static const maxCount = 20;
  List<LocationData> locationHistory = [];

  add(LocationData location) {
    if (locationHistory.length == maxCount) {
      locationHistory.removeAt(0);
    }
    locationHistory.add(location);
  }

  LocationData? getCurrentLocation() {
    if (locationHistory.isNotEmpty) {
      return locationHistory.last;
    } else {
      return null;
    }
  }
}
