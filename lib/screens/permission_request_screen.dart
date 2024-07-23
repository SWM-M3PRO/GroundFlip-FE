import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/permission_request_controller.dart';

class PermissionRequestScreen extends StatelessWidget {
  const PermissionRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PermissionRequestController permissionController =
        Get.put(PermissionRequestController());

    return Scaffold(
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
