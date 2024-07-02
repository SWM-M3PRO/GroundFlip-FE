import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/map_controller.dart';
import '../../enums/pixel_mode.dart';

class ModeChangeButton extends StatelessWidget {
  const ModeChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    var mapController = Get.find<MapController>();

    return Expanded(
      child: Align(
        alignment: Alignment.topRight,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            alignment: Alignment.center,
            isExpanded: true,
            items: PixelMode.values
                .map(
                  (PixelMode pixelMode) => DropdownMenuItem<String>(
                    value: pixelMode.koreanName,
                    child: Text(
                      pixelMode.koreanName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (pixelModeKrName) {
              mapController.changePixelMode(pixelModeKrName!);
            },
            value: mapController.currentPixelMode.value.koreanName,
            buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.blueAccent,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.blueAccent,
              ),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
      ),
    );
  }
}
