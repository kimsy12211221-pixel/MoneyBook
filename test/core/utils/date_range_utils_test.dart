import 'package:flutter_test/flutter_test.dart';
import 'package:personal_spending_app/core/utils/date_range_utils.dart';

void main() {
  group('DateRangeUtils', () {
    test('counts remaining days in month including today', () {
      final value = DateTime(2026, 8, 20);

      expect(DateRangeUtils.remainingDaysInMonthIncludingToday(value), 12);
    });

    test('uses Sunday as the final day of the credit week', () {
      final value = DateTime(2026, 8, 30);

      expect(DateRangeUtils.remainingDaysInWeekWithinMonth(value), 1);
    });

    test('builds year-month key', () {
      final value = DateTime(2026, 8, 30);

      expect(DateRangeUtils.yearMonthKey(value), '2026-08');
    });

    test('uses the 21st as the saving cycle boundary', () {
      expect(
        DateRangeUtils.savingCycleKey(DateTime(2026, 11, 20)),
        'saving_2026-10-21',
      );
      expect(
        DateRangeUtils.savingCycleKey(DateTime(2026, 11, 21)),
        'saving_2026-11-21',
      );
      expect(
        DateRangeUtils.savingCycleLabel(DateTime(2026, 11, 23)),
        'NOV 21 - DEC 20',
      );
    });
  });
}
