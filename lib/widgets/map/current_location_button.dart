import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/map_controller.dart';

class CurrentLocationButton extends StatefulWidget {
  const CurrentLocationButton({super.key});

  @override
  createState() => _CurrentLocationButtonState();
}

class _CurrentLocationButtonState extends State<CurrentLocationButton> {
  final MapController mapController = Get.find<MapController>();
  Color _buttonColor = AppColors.backgroundSecondary; // 기본 배경 색상
  final Color _pressedColor = Colors.grey; // 눌렀을 때의 배경 색상

  void _onPointerDown(DragDownDetails event) {
    setState(() {
      _buttonColor = _pressedColor;
    });
  }

  void _onPointerUp() {
    setState(() {
      _buttonColor = AppColors.backgroundSecondary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        mapController.focusOnCurrentLocation();
      },
      onPanDown: _onPointerDown,
      onPanEnd: (details) => _onPointerUp(),
      onPanCancel: () => _onPointerUp(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: _buttonColor,
        ),
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.my_location,
          color: Colors.white,
          size: 20, // 아이콘 크기
        ),
      ),
    );
  }
}
