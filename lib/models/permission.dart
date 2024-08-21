class Permission {
  final bool isServiceNotificationEnabled;
  final bool isMarketingNotificationEnabled;

  Permission({
    required this.isServiceNotificationEnabled,
    required this.isMarketingNotificationEnabled,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'isServiceNotificationEnabled': var isServiceNotificationEnabled,
        'isMarketingNotificationEnabled': var isMarketingNotificationEnabled,
      } =>
        Permission(
          isServiceNotificationEnabled: isServiceNotificationEnabled,
          isMarketingNotificationEnabled: isMarketingNotificationEnabled,
        ),
      _ => throw const FormatException('Failed to load Permission')
    };
  }
}
