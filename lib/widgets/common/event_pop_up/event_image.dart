import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../screens/setting_screen.dart';

class EventImage extends StatelessWidget {
  final String imageUrl;
  final int eventId;

  const EventImage({super.key, required this.imageUrl, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(SettingScreen());
      },
      child: Image(
        image: CachedNetworkImageProvider(imageUrl),
        fit: BoxFit.cover,
      ),
    );
  }
}
