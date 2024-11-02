class Notification {
  final int notificationId;
  final String category;
  final int categoryId;
  final String title;
  final DateTime date;
  final int? contentId;
  final String? contents;
  bool isRead;

  Notification({
    required this.notificationId,
    required this.category,
    required this.categoryId,
    required this.title,
    required this.date,
    required this.contentId,
    required this.contents,
    required this.isRead,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'notificationId': var notificationId,
        'category': var category,
        'categoryId': var categoryId,
        'title': var title,
        'date': var date,
        'contentId': var contentId,
        'contents': var contents,
        'isRead': var isRead,
      } =>
        Notification(
          notificationId: notificationId,
          category: category,
          categoryId: categoryId,
          date: DateTime.parse(date),
          title: title,
          contentId: contentId,
          contents: contents,
          isRead: isRead,
        ),
      _ => throw const FormatException('Failed to load Notification')
    };
  }

  static List<Notification> listFromJson(List<dynamic> jsonList) {
    return [
      for (var element in jsonList) Notification.fromJson(element),
    ];
  }
}
