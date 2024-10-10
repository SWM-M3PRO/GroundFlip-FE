import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/map_controller.dart';

class LogScreen extends StatelessWidget {
  final List<String> logs;
  final MapController mapController = Get.find<MapController>();

  LogScreen({required this.logs});

  // 모든 로그를 하나의 문자열로 합침
  String get allLogs => logs.join('\n');

  void copyAllLogs(BuildContext context) {
    Clipboard.setData(ClipboardData(text: allLogs));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("모든 로그가 클립보드에 복사되었습니다.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logs'),
        actions: [
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () => copyAllLogs(context), // 모든 로그 복사
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              mapController.initLogs();
            }, // 모든 로그 복사
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: SelectableText(
              logs[index],
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
