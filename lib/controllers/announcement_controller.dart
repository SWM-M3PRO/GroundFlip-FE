import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/announcement.dart';
import '../service/announcement_service.dart';
import '../widgets/announcement/announcement_element.dart';

class AnnouncementController extends GetxController {
  var items = <AnnouncementElement>[].obs; // 관찰 가능한 리스트
  var isLoading = false.obs; // 로딩 상태 관리
  final ScrollController scrollController = ScrollController();
  final AnnouncementService announcementService = AnnouncementService();
  final Announcement announcement = Announcement(
      title: 'V1.0.6 업데이트 공지', announcementId: 1, date: DateTime.now());

  @override
  void onInit() {
    super.onInit();
    loadInitialItems(); // 초기 데이터 로드
    scrollController.addListener(_onScroll); // 스크롤 이벤트 리스너 추가
  }

  Future<void> loadInitialItems() async {
    final List<Announcement> announcements =
        await announcementService.getAnnouncements(0);
    final List<AnnouncementElement> newItems = announcements
        .map((announcement) => AnnouncementElement(announcement: announcement))
        .toList();

    items.addAll(newItems); // 초기 20개 항목 로드
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
        await announcementService.getAnnouncements(0);
    final List<AnnouncementElement> newItems = announcements
        .map((announcement) => AnnouncementElement(announcement: announcement))
        .toList();
    items.addAll(newItems);
    isLoading.value = false;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
