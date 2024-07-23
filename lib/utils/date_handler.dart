class DateHandler {
  static final DateTime startDate = DateTime(2024, 6, 3);

  static String formatDate(DateTime date) {
    String year = date.year.toString().padLeft(4, '0');
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');

    return '$year.$month.$day';
  }

  static bool isTodayInRange(DateTime startDate, DateTime endDate) {
    DateTime today = DateTime.now();
    DateTime todayOnly = DateTime(today.year, today.month, today.day);
    DateTime startDateOnly =
        DateTime(startDate.year, startDate.month, startDate.day);
    DateTime endDateOnly = DateTime(endDate.year, endDate.month, endDate.day);

    return (todayOnly.isAfter(startDateOnly) &&
            todayOnly.isBefore(endDateOnly)) ||
        todayOnly.isAtSameMomentAs(startDateOnly) ||
        todayOnly.isAtSameMomentAs(endDateOnly);
  }

  static String convertDateToWeekFormat(DateTime weekStartDate) {
    DateTime weekEndDate = weekStartDate.add(Duration(days: 6));
    return '${weekStartDate.year}년 ${weekStartDate.month.toString().padLeft(2, '0')}월 ${weekStartDate.day.toString().padLeft(2, '0')}일 ~ ${weekEndDate.day.toString().padLeft(2, '0')}일';
  }

  static String convertDateToWeekFormatWithoutYear(DateTime weekStartDate) {
    DateTime weekEndDate = weekStartDate.add(Duration(days: 6));
    return '${weekStartDate.month.toString().padLeft(2, '0')}월 ${weekStartDate.day.toString().padLeft(2, '0')}일 ~ ${weekEndDate.day.toString().padLeft(2, '0')}일';
  }

  static DateTime getStartOfThisWeek() {
    return getStartOfWeek(DateTime.now());
  }

  static DateTime getStartOfWeek(DateTime date) {
    int currentWeekday = date.weekday;
    DateTime startOfWeek = date.subtract(Duration(days: currentWeekday - 1));
    return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
  }

  static List<DateTime> getDatesFromStartToThisWeek() {
    List<DateTime> dates = [];
    DateTime thisWeekStart = getStartOfThisWeek();

    DateTime current = thisWeekStart;
    while (current.isAfter(startDate) || current.isAtSameMomentAs(startDate)) {
      dates.add(DateTime(current.year, current.month, current.day)); // 앞에 추가
      current = current.subtract(Duration(days: 7)); // 7일씩 빼기
    }
    return dates;
  }
}
