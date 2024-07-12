import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const SettingsItem({required this.title, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
      onTap: onTap,
    );
  }
}
