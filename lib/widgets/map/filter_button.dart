import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  // final MapController mapController = Get.find<MapController>();
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
      onTap: () {},
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
          Icons.filter_none_rounded,
          color: Colors.white,
          size: 20, // 아이콘 크기
        ),
      ),
    );
  }
}
