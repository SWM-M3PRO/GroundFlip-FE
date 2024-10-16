import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/announcement_controller.dart';
import '../../models/announcement.dart';

class AnnouncementElement extends StatelessWidget {
  final Announcement announcement;
  final AnnouncementController controller = Get.find<AnnouncementController>();

  AnnouncementElement({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.showAnnouncement(announcement.announcementId);
      },
      child: Container(
        width: 800,
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  announcement.title,
                  style: TextStyles.fs17w700cTextPrimary,
                ),
                Spacer(),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat('yyyy.MM.dd').format(announcement.date),
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ),
            Divider(
              height: 20,
              thickness: 0.3,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
