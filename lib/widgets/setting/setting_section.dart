import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class SettingsSection extends StatelessWidget {
  final String? title;
  final List<Widget> items;

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
        Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: AppColors.backgroundSecondary,
          ),
          child: Column(
            children: items.map((item) => item).toList(),
          ),
        ),
      ],
    );
  }
}
