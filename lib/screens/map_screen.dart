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
      body: mapController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target: LatLng(37.505200, 127.046748), zoom: 16.0),
              onMapCreated: (GoogleMapController ctrl) {
                mapController.completer.complete(ctrl);
              },
              style: mapController.darkMapStyle,
            ),
    );
  }
}
