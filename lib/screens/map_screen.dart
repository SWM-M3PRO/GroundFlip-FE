import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/map_controller.dart';
import '../controllers/permission_controller.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PermissionController permissionController =
    Get.put(PermissionController());
    final MapController mapController = Get.put(MapController());

    return Scaffold(
        body: Obx(() {
          if (mapController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  mapController.currentLocation.latitude!,
                  mapController.currentLocation.longitude!,),
                zoom: 16.0,
              ),
              onMapCreated: (GoogleMapController ctrl) {
                mapController.completer.complete(ctrl);
              },
              style: mapController.darkMapStyle,
              markers: mapController.markers,
            );
          }
        }),
    );
  }
}
