import 'package:dio/dio.dart';

import '../models/announcement.dart';
import '../models/announcement_info.dart';
import '../models/event.dart';
import '../utils/dio_service.dart';

class AnnouncementService {
  static final AnnouncementService _instance = AnnouncementService._internal();

  final Dio dio = DioService().getDio();

  AnnouncementService._internal();

  factory AnnouncementService() {
    return _instance;
  }

  Future<List<Event>> getEvents() async {
    try {
      var response = await dio.get('/announcement/events');
      return Event.listFromJson(response.data['data']);
    } catch (e) {
      return [];
    }
  }

  Future<List<Announcement>> getAnnouncements(int cursor) async {
    var response = await dio.get(
      '/announcement',
      queryParameters: {
        "cursor": cursor,
      },
    );
    return Announcement.listFromJson(response.data['data']);
  }

  Future<AnnouncementInfo> getAnnouncementContent(int announcementId) async {
    var response = await dio.get(
      '/announcement/$announcementId',
    );
    return AnnouncementInfo.fromJson(response.data['data']);
  }

  Future<void> increaseEventViewCount(int eventId) async {
    try {
      await dio.get(
        '/announcement/events/$eventId/views',
      );
    } catch (e) {
      return;
    }
  }
}
