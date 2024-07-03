import 'package:flutter/material.dart';

import '../../models/individual_mode_pixel_info.dart';

class PixelOwnerInfo extends StatelessWidget {
  const PixelOwnerInfo({super.key, required this.pixelOwnerUser});

  final PixelOwnerUser pixelOwnerUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ClipOval(
          child: pixelOwnerUser.profileImageUrl != null
              ? Image.network(
                  pixelOwnerUser.profileImageUrl!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/default_profile_image.png',
                  width: 50,
                  height: 50,
                ),
        ),
        Text(
          pixelOwnerUser.nickname!,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          pixelOwnerUser.currentPixelCount.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          pixelOwnerUser.accumulatePixelCount.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
