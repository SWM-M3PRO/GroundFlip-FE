import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';

class AnnouncementScreen extends StatelessWidget {
  final String title;
  final DateTime date;
  final String content;

  const AnnouncementScreen(
      {super.key,
      required this.title,
      required this.date,
      required this.content,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.fs20w600cTextPrimary,
            ),
            Text(
              DateFormat('yyyy.MM.dd').format(date),
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Markdown(
          data: content,
          styleSheet: MarkdownStyleSheet(
            h1: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,),
            h2: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white,),
            h3: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),
            h4: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),
            h5: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),
            h6: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white,),

            p: TextStyle(fontSize: 16, color: Colors.white),
            strong: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),
            em: TextStyle(
                fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white,),

            blockquote: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
            blockquotePadding: EdgeInsets.all(12),
            blockquoteDecoration: BoxDecoration(
              color: Colors.grey.shade800, // 어두운 회색 배경
              border: Border(
                left: BorderSide(color: AppColors.primary, width: 4),
              ),
            ),
            code: TextStyle(
                fontSize: 16,
                fontFamily: 'monospace',
                color: Colors.yellowAccent,),

            a: TextStyle(
                fontSize: 16,
                color: AppColors.primary,
                decoration: TextDecoration.underline,),
            del: TextStyle(
                fontSize: 16,
                color: Colors.red,
                decoration: TextDecoration.lineThrough,),

            listBullet: TextStyle(fontSize: 16, color: Colors.white),
            listIndent: 24.0,

            blockSpacing: 8.0,
            // 각 블록 사이의 간격
            horizontalRuleDecoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey)),),

            textAlign: WrapAlignment.start,
            // textScaleFactor: 1.0,
            checkbox: TextStyle(color: Colors.lightGreenAccent, fontSize: 16),
          ),
          onTapLink: (text, url, title) {
            if (url != null) {
              launchUrl(Uri.parse(url));
            }
          },
        ),
      ),
    );
  }
}
