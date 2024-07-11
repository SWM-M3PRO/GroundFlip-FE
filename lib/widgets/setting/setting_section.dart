import 'package:flutter/material.dart';

import 'setting_item.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<SettingsItem> items;

  SettingsSection({required this.title, required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Column(
          children: items.map((item) => item).toList(),
        ),
      ],
    );
  }
}
