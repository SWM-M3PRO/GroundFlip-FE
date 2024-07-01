import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/map_controller.dart';
import '../controllers/permission_controller.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PermissionController());
    final MapController mapController = Get.put(MapController());

    return Scaffold(
      body: Obx(() {
        if (mapController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    mapController.currentLocation.latitude!,
                    mapController.currentLocation.longitude!,
                  ),
                  zoom: 16.0,
                ),
                onMapCreated: (GoogleMapController ctrl) {
                  mapController.completer.complete(ctrl);
                },
                style: mapController.mapStyle,
                markers: Set<Marker>.of(mapController.markers),
                polygons: Set<Polygon>.of(mapController.pixels),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 60.0, ),
                  child: Container(
                    width: 100.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.black54,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: '개인전',
                        onChanged: (String? newValue) {
                        },
                        items: <String>['개인전', '그룹전', '개인 기록']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(value,
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
