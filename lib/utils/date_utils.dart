class DateUtils {
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
}
