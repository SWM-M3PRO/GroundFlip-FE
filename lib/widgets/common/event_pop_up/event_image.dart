import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/announcement_info.dart';
import '../../../screens/announcement_screen.dart';
import '../../../service/announcement_service.dart';

class EventImage extends StatelessWidget {
  final String imageUrl;
  final int? announcementId;
  final int eventId;
  final AnnouncementService announcementService = AnnouncementService();

  EventImage({
    super.key,
    required this.imageUrl,
    required this.announcementId,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (announcementId != null) {
          announcementService.increaseEventViewCount(eventId);
          AnnouncementInfo announcement =
              await announcementService.getAnnouncementContent(announcementId!);
          Get.to(
            AnnouncementScreen(
              title: announcement.title,
              date: announcement.date,
              content: announcement.content,
            ),
          );
        }
      },
      child: Image(
        image: CachedNetworkImageProvider(imageUrl),
        fit: BoxFit.cover,
      ),
    );
  }
}
