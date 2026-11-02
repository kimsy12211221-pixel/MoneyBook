import 'package:flutter_test/flutter_test.dart';
import 'package:personal_spending_app/domain/services/safe_to_spend_service.dart';

void main() {
  const service = SafeToSpendService();

  group('SafeToSpendService', () {
    test('carries an overspend as negative credit into tomorrow', () {
      final snapshot = service.calculate(
        monthlyBudget: 1500000,
        spentThisMonth: 60000,
        upcomingReserved: 0,
        now: DateTime(2026, 4, 1),
        remainingDaysInCurrentWeek: 7,
      );

      expect(snapshot.dailyCredit, 50000);
      expect(snapshot.creditBalance, -10000);
      expect(snapshot.dailySafe, 0);
      expect(snapshot.isCreditDebt, isTrue);
      expect(snapshot.creditDebtAmount, 10000);

      final tomorrowCredit = service.calculateDailyCredit(
        monthlyBudget: 1500000,
        dayOfMonth: 2,
        daysInMonth: 30,
      );
      expect(snapshot.creditBalance + tomorrowCredit, 40000);
    });

    test('accumulates unused credit and includes this week remaining charges',
        () {
      final snapshot = service.calculate(
        monthlyBudget: 1200000,
        spentThisMonth: 0,
        upcomingReserved: 0,
        now: DateTime(2026, 9, 7),
        remainingDaysInCurrentWeek: 7,
      );

      expect(snapshot.dailyCredit, 40000);
      expect(snapshot.creditBalance, 280000);
      expect(snapshot.weeklyCreditBalance, 520000);
      expect(snapshot.dailySafe, 280000);
      expect(snapshot.weeklySafe, 520000);
    });

    test('weekly view includes future daily credits after a negative balance',
        () {
      final snapshot = service.calculate(
        monthlyBudget: 1500000,
        spentThisMonth: 400000,
        upcomingReserved: 0,
        now: DateTime(2026, 4, 6),
        remainingDaysInCurrentWeek: 7,
      );

      expect(snapshot.creditBalance, -100000);
      expect(snapshot.weeklyCreditBalance, 200000);
      expect(snapshot.isCreditDebt, isTrue);
      expect(snapshot.isOverBudget, isFalse);
    });

    test('keeps monthly over-budget separate from current credit debt', () {
      final snapshot = service.calculate(
        monthlyBudget: 300000,
        spentThisMonth: 260000,
        upcomingReserved: 80000,
        now: DateTime(2026, 4, 26),
        remainingDaysInCurrentWeek: 5,
      );

      expect(snapshot.monthlyAvailable, -40000);
      expect(snapshot.monthlySafe, 0);
      expect(snapshot.isOverBudget, isTrue);
      expect(snapshot.overBudgetAmount, 40000);
    });

    test('returns null wishlist impact when current credit is zero', () {
      final impact = service.calculateWishlistImpactDays(
        price: 189000,
        currentDailySafe: 0,
      );

      expect(impact, isNull);
    });
  });
}
