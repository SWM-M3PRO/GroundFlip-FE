class Event {
  final String eventImageUrl;
  final int? announcementId;

  Event({
    required this.eventImageUrl,
    required this.announcementId,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'eventImageUrl': var eventImageUrl,
        'announcementId': var eventId,
      } =>
        Event(
          eventImageUrl: eventImageUrl,
          announcementId: eventId,
        ),
      _ => throw const FormatException('Failed to load Pixel')
    };
  }

  static List<Event> listFromJson(List<dynamic> jsonList) {
    return [
      for (var element in jsonList) Event.fromJson(element),
    ];
  }
}
