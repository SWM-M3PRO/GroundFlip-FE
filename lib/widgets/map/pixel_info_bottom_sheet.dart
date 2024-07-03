import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ground_flip/widgets/map/pixel_owner_info.dart';
import 'package:ground_flip/widgets/map/visited_user_list_view.dart';

import '../../controllers/map_controller.dart';

class PixelInfoBottomSheet extends StatelessWidget {
  PixelInfoBottomSheet({super.key, required this.pixelId});

  final int pixelId;
  final MapController mapController = Get.find<MapController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF374957),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: SizedBox(
        height: 400,
        width: 380,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '은평구 n번째 픽셀',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              PixelOwnerInfo(),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '오늘 17명이 차지했었어요!',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              VisitedUserListView(),
            ],
          ),
        ),
      ),
    );
  }
}
