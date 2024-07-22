import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import 'setting_item.dart';

class SettingsSection extends StatelessWidget {
  final String? title;
  final List<SettingsItem> items;

  SettingsSection({this.title, required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        if (title != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
            child: Text(title!, style: TextStyles.fs14w400cTextSecondary),
          ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: items.map((item) => item).toList(),
          ),
        ),
      ],
    );
  }
}
