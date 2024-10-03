import 'package:get/get.dart';

import '../models/user.dart';
import '../models/user_pixel_count.dart';
import '../service/pixel_service.dart';
import '../service/user_service.dart';
import '../utils/date_handler.dart';

class MyPageController extends GetxController {
  final UserService userService = UserService();
  final PixelService pixelService = PixelService();
  final Rx<User> currentUserInfo = User().obs;
  final RxInt currentPixelCount = 0.obs;
  final RxInt accumulatePixelCount = 0.obs;
  final RxList<int> selectedWeeklyPixelCount = <int>[0, 0, 0, 0, 0, 0, 0].obs;
  final RxString selectedWeekInfo = "".obs;
  final RxBool isNextButtonEnabled = false.obs;
  final RxBool isPreviousButtonEnabled = true.obs;
  late DateTime selectedWeekStartDate;
  late DateTime selectedWeekEndDate;

  static DateTime checkFirstDate = DateTime.parse('2024-06-01');

  @override
  Future<void> onInit() async {
    super.onInit();
    await updateUserInfo();
    await _updatePixelCount();
    initSelectedWeek();
    _initializeWeeklySteps();
  }

  void initSelectedWeek() {
    DateTime nowDate = DateTime.now();
    selectedWeekStartDate =
        nowDate.subtract(Duration(days: nowDate.weekday - 1));
    selectedWeekEndDate =
        nowDate.add(Duration(days: DateTime.daysPerWeek - nowDate.weekday));
    _updateSelectedWeekInfo();
  }

  Future<void> _initializeWeeklySteps() async {
    DateTime nowDate = DateTime.now();
    selectedWeekStartDate =
        nowDate.subtract(Duration(days: nowDate.weekday - 1));
    selectedWeekEndDate =
        nowDate.add(Duration(days: DateTime.daysPerWeek - nowDate.weekday));

    _updateSelectedWeekInfo();
    _updateSelectedWeeklyPixelCount();
  }

  _updatePixelCount() async {
    UserPixelCount currentUserPixelCount =
        await userService.getUserPixelCount(null);
    currentPixelCount.value = currentUserPixelCount.currentPixelCount!;
    accumulatePixelCount.value = currentUserPixelCount.accumulatePixelCount!;
  }

  updateUserInfo() async {
    User userInfo = await userService.getCurrentUserInfo();
    currentUserInfo.value = userInfo;
  }

  getProfileImageURL() {
    return currentUserInfo.value.profileImageUrl;
  }

  String getCurrentUserNickname() {
    return currentUserInfo.value.nickname ?? "-";
  }

  String? getCurrentUserCommunityName() {
    return currentUserInfo.value.communityName;
  }

  getIsNextButtonEnabled() {
    return isNextButtonEnabled.value;
  }

  getIsPreviousButtonEnabled() {
    return isPreviousButtonEnabled.value;
  }

  String getSelectedWeekInfo() {
    return selectedWeekInfo.value;
  }

  void _updateSelectedWeekInfo() {
    selectedWeekInfo.value =
        DateHandler.convertDateToWeekFormatWithoutYear(selectedWeekStartDate);
  }

  Future<void> loadPreviousWeeklyPixelCount() async {
    selectedWeekStartDate = selectedWeekStartDate.subtract(Duration(days: 7));
    selectedWeekEndDate = selectedWeekEndDate.subtract(Duration(days: 7));
    _loadWeeklyPixelCount();
  }

  Future<void> loadNextWeeklyPixelCount() async {
    selectedWeekStartDate = selectedWeekStartDate.add(Duration(days: 7));
    selectedWeekEndDate = selectedWeekEndDate.add(Duration(days: 7));
    _loadWeeklyPixelCount();
  }

  Future<void> _loadWeeklyPixelCount() async {
    _updateSelectedWeeklyPixelCount();
    _updateSelectedWeekInfo();
    _updateNextButtonStatus();
    _updatePreviousButtonStatus();
  }

  _updateSelectedWeeklyPixelCount() async {
    List<int> thisWeeklyPixelCount =
        await pixelService.getDailyPixelsInInterval(
      selectedWeekStartDate,
      selectedWeekEndDate,
    );
    selectedWeeklyPixelCount.assignAll(thisWeeklyPixelCount);
  }

  _updateNextButtonStatus() {
    if (DateHandler.isTodayInRange(
      selectedWeekStartDate,
      selectedWeekEndDate,
    )) {
      isNextButtonEnabled.value = false;
    } else {
      isNextButtonEnabled.value = true;
    }
  }

  _updatePreviousButtonStatus() {
    if (checkFirstDate.isAfter(selectedWeekStartDate)) {
      isPreviousButtonEnabled.value = false;
    } else {
      isPreviousButtonEnabled.value = true;
    }
  }

  double getMaxCount() {
    int maxCount = selectedWeeklyPixelCount.toList()[0];
    for (int number in selectedWeeklyPixelCount.toList()) {
      if (number > maxCount) {
        maxCount = number;
      }
    }
    print(selectedWeeklyPixelCount.toList());
    print(maxCount);
    if (maxCount == 0) {
      return 100;
    } else {
      return (maxCount / 10).ceil() * 10;
    }
  }

  List<int> getWeeklyPixelCount() {
    return selectedWeeklyPixelCount.toList();
  }
}
