import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/app_colors.dart';
import '../../controllers/map_controller.dart';
import '../../service/my_place_service.dart';

class MyPlaceButtonIcon extends StatelessWidget {
  MyPlaceService myPlaceService = MyPlaceService();
  MapController mapController = Get.find<MapController>();

  final IconData icon;
  final String place;
  final box = GetStorage();

  MyPlaceButtonIcon({required this.icon, required this.place});

  @override
  Widget build(BuildContext context) {
    double latitude;
    double longitude;
    if (box.read(place) == null) {
      return Container();
    }else{
      latitude = box.read(place).x;
      longitude = box.read(place).y;
    }
    return GestureDetector(
      onTap: () {
        if (place == 'MyPlace') {
          mapController.myPlaceButtonVisible.value =
              !mapController.myPlaceButtonVisible.value;
        } else {
          mapController.setCameraOnLocation(latitude, longitude);
        }
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.backgroundSecondary),
        child: Icon(
          icon,
          size: 20,
          color: AppColors.buttonColor,
        ),
      ),
    );
  }
}
