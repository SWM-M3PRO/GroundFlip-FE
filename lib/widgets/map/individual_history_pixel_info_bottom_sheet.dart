import 'package:flutter/material.dart';

import '../../models/individual_history_pixel_info.dart';

class IndividualHistoryPixelInfoBottomSheet extends StatelessWidget {
  const IndividualHistoryPixelInfoBottomSheet({super.key, required this.pixelInfo});

  final IndividualHistoryPixelInfo pixelInfo;
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
      ),
    );
  }
}
