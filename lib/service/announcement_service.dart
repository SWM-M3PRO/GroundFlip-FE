import 'package:dio/dio.dart';

import '../models/announcement.dart';
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
    var response = await dio.get('/announcement/events');
    return Event.listFromJson(response.data['data']);
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
}
