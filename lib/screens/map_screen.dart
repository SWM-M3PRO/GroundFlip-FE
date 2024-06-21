import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controllers/permission_controller.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PermissionController mapScreenController =
    Get.put(PermissionController());

    return const Column(
      children: [
        Text('지도'),
      ],
    );
  }
}
