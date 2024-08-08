import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/app_colors.dart';
import '../controllers/map_controller.dart';
import '../service/location_service.dart';

class MyPlaceScreen extends StatelessWidget {
  MyPlaceScreen({super.key});

  final MapController mapController = Get.find<MapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (mapController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        } else {
          return Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Obx(
                () {
                  return Listener(
                    onPointerDown: (e) {
                      mapController.isCameraTrackingUser = false.obs;
                    },
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          LocationService().currentLocation!.latitude!,
                          LocationService().currentLocation!.longitude!,
                        ),
                        zoom: 16.0,
                      ),
                      onCameraMove: mapController.updateCameraPosition,
                      //onCameraIdle: mapController.onCameraIdle,
                      onMapCreated: (GoogleMapController ctrl) {
                        mapController.googleMapController2 = ctrl;
                      },
                      myLocationEnabled: false,
                      style: mapController.mapStyle,
                      markers: Set<Marker>.of(mapController.markers),
                      onTap: (LatLng latLng) {
                        mapController.updateMarker(latLng);
                      },
                    ),
                  );
                },
              ),
              Positioned(
                top: 60,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    mapController.openMyPlaceBottomSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.primary,),
                    child: Text(
                      '등록',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
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
