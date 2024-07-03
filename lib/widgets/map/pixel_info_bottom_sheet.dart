import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/map_controller.dart';

class PixelInfoBottomSheet extends StatelessWidget {
  PixelInfoBottomSheet({super.key, required this.pixelId});

  final int pixelId;
  final MapController mapController = Get.find<MapController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: SizedBox(
        height: 400,
        width: 380,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'bottom sheet',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: Get.back,
              child: const Text('닫기'),
            ),
          ],
        ),
      ),
    );
  }
}
