class Notification {
  final String category;
  final int categoryId;
  final String contents;
  final DateTime date;
  bool isRead;

  Notification({
    required this.category,
    required this.categoryId,
    required this.contents,
    required this.date,
    required this.isRead,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'category': var category,
        'categoryId': var categoryId,
        'contents': var contents,
        'date': var date,
        'isRead': var isRead,
      } =>
        Notification(
          category: category,
          categoryId: categoryId,
          date: DateTime.parse(date),
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
