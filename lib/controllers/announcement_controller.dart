import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/announcement.dart';
import '../models/announcement_info.dart';
import '../screens/announcement_screen.dart';
import '../service/announcement_service.dart';
import '../widgets/announcement/announcement_element.dart';

class AnnouncementController extends GetxController {
  var items = <AnnouncementElement>[].obs;
  var isLoading = false.obs;
  var lastItemIndex = 0;

  final ScrollController scrollController = ScrollController();
  final AnnouncementService announcementService = AnnouncementService();
  final Announcement announcement = Announcement(
    title: 'V1.0.6 업데이트 공지',
    announcementId: 1,
    date: DateTime.now(),
  );

  @override
  void onInit() {
    super.onInit();
    loadInitialItems();
    scrollController.addListener(_onScroll);
  }

  Future<void> loadInitialItems() async {
    final List<Announcement> announcements =
        await announcementService.getAnnouncements(lastItemIndex);
    final List<AnnouncementElement> newItems = announcements
        .map((announcement) => AnnouncementElement(announcement: announcement))
        .toList();
    lastItemIndex = announcements[announcements.length - 1].announcementId;
    items.addAll(newItems);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoading.value) {
      fetchMoreItems();
    }
  }

  Future<void> fetchMoreItems() async {
    isLoading.value = true;
    final List<Announcement> announcements =
        await announcementService.getAnnouncements(lastItemIndex);
    final List<AnnouncementElement> newItems = announcements
        .map((announcement) => AnnouncementElement(announcement: announcement))
        .toList();
    lastItemIndex = announcements[announcements.length - 1].announcementId;
    items.addAll(newItems);
    isLoading.value = false;
  }

  showAnnouncement(int announcementId) async {
    AnnouncementInfo announcement =
        await announcementService.getAnnouncementContent(announcementId);
    Get.to(
      AnnouncementScreen(
        title: announcement.title,
        date: announcement.date,
        content: announcement.content,
      ),
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
