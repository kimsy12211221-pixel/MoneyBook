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

  /// Saving plans follow payday: the 21st through the 20th of next month.
  static DateTime savingCycleStart(DateTime value) {
    if (value.day >= 21) {
      return DateTime(value.year, value.month, 21);
    }
    return DateTime(value.year, value.month - 1, 21);
  }

  static String savingCycleKey(DateTime value) {
    final start = savingCycleStart(value);
    return 'saving_${start.year}-${start.month.toString().padLeft(2, '0')}-21';
  }

  static String savingCycleLabel(DateTime value) {
    final start = savingCycleStart(value);
    final end = DateTime(start.year, start.month + 1, 20);
    return '${monthShortLabel(start.month)} 21 - ${monthShortLabel(end.month)} 20';
  }

  static String shortDateLabel(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '$month / $day';
  }

  static String monthDayLabel(DateTime value) {
    final label = monthShortLabel(value.month);
    final day = value.day.toString().padLeft(2, '0');
    return '$label $day';
  }

  static String monthShortLabel(int month) {
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
    return months[month - 1];
  }
}
