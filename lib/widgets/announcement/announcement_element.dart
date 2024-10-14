import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../models/announcement.dart';

class AnnouncementElement extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementElement({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            announcement.title,
            style: TextStyles.fs17w700cTextPrimary,
          ),
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
    );
  }
}
