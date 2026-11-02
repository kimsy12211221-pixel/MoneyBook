class DateRangeUtils {
  const DateRangeUtils._();

  static DateTime startOfMonth(DateTime value) {
    return DateTime(value.year, value.month);
  }

  static DateTime endOfMonth(DateTime value) {
    return DateTime(value.year, value.month + 1, 0, 23, 59, 59, 999);
  }

  static DateTime startOfYear(DateTime value) => DateTime(value.year);

  static DateTime endOfYear(DateTime value) =>
      DateTime(value.year, 12, 31, 23, 59, 59, 999);

  static int remainingDaysInMonthIncludingToday(DateTime value) {
    final lastDay = DateTime(value.year, value.month + 1, 0).day;
    return lastDay - value.day + 1;
  }

  static int remainingDaysInWeekWithinMonth(DateTime value) {
    final endOfWeekDay = DateTime.sunday;
    final remainingThisWeek = ((endOfWeekDay - value.weekday) % 7) + 1;
    final remainingThisMonth = remainingDaysInMonthIncludingToday(value);
    return remainingThisWeek < remainingThisMonth
        ? remainingThisWeek
        : remainingThisMonth;
  }

  static String yearMonthKey(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    return '${value.year}-$month';
  }

  static String shortDateLabel(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '$month / $day';
  }

  static String monthDayLabel(DateTime value) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    final label = months[value.month - 1];
    final day = value.day.toString().padLeft(2, '0');
    return '$label $day';
  }
}
