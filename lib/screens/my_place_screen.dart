import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/app_colors.dart';
import '../controllers/my_place_controller.dart';
import '../service/location_service.dart';

class MyPlaceScreen extends StatelessWidget {
  MyPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyPlaceController myPlaceController = Get.put(MyPlaceController());

    final PreferredSizeWidget appBar = AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.buttonColor,
        ),
      ),
      backgroundColor: AppColors.background,
      title: Text(
        '내 장소 등록',
        style: TextStyle(
          color: AppColors.textPrimary,
        ),
      ),
    );

    final double appBarHeight = appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: Obx(() {
        if (myPlaceController.isLoading.value) {
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
                  return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        LocationService().currentLocation!.latitude!,
                        LocationService().currentLocation!.longitude!,
                      ),
                      zoom: 16.0,
                    ),
                    onMapCreated: (GoogleMapController ctrl) {
                      myPlaceController.googleMapController = ctrl;
                    },
                    myLocationEnabled: false,
                    style: myPlaceController.mapStyle,
                    markers: Set<Marker>.of(myPlaceController.markers),
                    onCameraIdle: () async {
                      final GoogleMapController? controller =
                          myPlaceController.googleMapController;
                      LatLng center = LatLng(
                        LocationService().currentLocation!.latitude!,
                        LocationService().currentLocation!.longitude!,
                      );
                      if (controller != null) {
                        center = await controller.getLatLng(
                          ScreenCoordinate(
                            x: MediaQuery.of(context).size.width ~/ 2,
                            y: (MediaQuery.of(context).size.height-appBarHeight) ~/ 2,
                          ),
                        );
                      } else {
                        print('googlemap is null');
                      }
                      myPlaceController.updateCoordinate(center);
                    },
                  );
                },
              ),
              Positioned(
                top: 20,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    myPlaceController.openMyPlaceBottomSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.primary,
                    ),
                    child: Text(
                      '등록',
                      style: TextStyle(
                        color: AppColors.textBlack,
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
