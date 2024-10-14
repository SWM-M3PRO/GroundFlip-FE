class Announcement {
  final String title;
  final int announcementId;
  final DateTime date;

  Announcement({
    required this.title,
    required this.announcementId,
    required this.date,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'title': var title,
        'announcementId': var announcementId,
        'date': var date,
      } =>
        Announcement(
          title: title,
          announcementId: announcementId,
          date: DateTime.parse(date),
        ),
      _ => throw const FormatException('Failed to load Announcement')
    };
  }

  static List<Announcement> listFromJson(List<dynamic> jsonList) {
    return [
      for (var element in jsonList) Announcement.fromJson(element),
    ];
  }
}
