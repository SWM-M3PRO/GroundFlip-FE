class AnnouncementInfo {
  final String title;
  final int announcementId;
  final DateTime date;
  final String content;

  AnnouncementInfo({
    required this.title,
    required this.announcementId,
    required this.date,
    required this.content,
  });

  factory AnnouncementInfo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'title': var title,
        'announcementId': var announcementId,
        'createdAt': var date,
        'content': var content,
      } =>
        AnnouncementInfo(
          title: title,
          announcementId: announcementId,
          date: DateTime.parse(date),
          content: content,
        ),
      _ => throw const FormatException('Failed to load Announcement')
    };
  }

  static List<AnnouncementInfo> listFromJson(List<dynamic> jsonList) {
    return [
      for (var element in jsonList) AnnouncementInfo.fromJson(element),
    ];
  }
}
