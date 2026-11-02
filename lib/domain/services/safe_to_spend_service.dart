import '../models/safe_to_spend_snapshot.dart';

class SafeToSpendService {
  const SafeToSpendService();

  SafeToSpendSnapshot calculate({
    required int monthlyBudget,
    required int spentThisMonth,
    required int upcomingReserved,
    required DateTime now,
    required int remainingDaysInCurrentWeek,
  }) {
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final chargedCredit = calculateCreditThroughDay(
      monthlyBudget: monthlyBudget,
      dayOfMonth: now.day,
      daysInMonth: daysInMonth,
    );
    final dailyCredit = calculateDailyCredit(
      monthlyBudget: monthlyBudget,
      dayOfMonth: now.day,
      daysInMonth: daysInMonth,
    );
    final monthlyAvailable = calculateMonthlyAvailable(
      monthlyBudget: monthlyBudget,
      spentThisMonth: spentThisMonth,
      upcomingReserved: upcomingReserved,
    );

    final creditBalance = chargedCredit - spentThisMonth - upcomingReserved;
    final lastDayOfCurrentWeek = (now.day + remainingDaysInCurrentWeek - 1)
        .clamp(now.day, daysInMonth)
        .toInt();
    final creditAtWeekEnd = calculateCreditThroughDay(
      monthlyBudget: monthlyBudget,
      dayOfMonth: lastDayOfCurrentWeek,
      daysInMonth: daysInMonth,
    );
    final weeklyCreditBalance = creditBalance + creditAtWeekEnd - chargedCredit;

    final isOverBudget = monthlyAvailable < 0;
    final isCreditDebt = creditBalance < 0;

    return SafeToSpendSnapshot(
      // Wishlist uses a non-negative affordability value. Home renders the
      // signed balances below so overspending remains visible to the user.
      dailySafe: creditBalance > 0 ? creditBalance : 0,
      weeklySafe: weeklyCreditBalance > 0 ? weeklyCreditBalance : 0,
      monthlySafe: monthlyAvailable > 0 ? monthlyAvailable : 0,
      monthlyAvailable: monthlyAvailable,
      dailyCredit: dailyCredit,
      creditBalance: creditBalance,
      weeklyCreditBalance: weeklyCreditBalance,
      remainingDaysInMonth: daysInMonth - now.day + 1,
      remainingDaysInCurrentWeek: remainingDaysInCurrentWeek,
      spentThisMonth: spentThisMonth,
      upcomingReserved: upcomingReserved,
      isOverBudget: isOverBudget,
      overBudgetAmount: isOverBudget ? monthlyAvailable.abs() : 0,
      isCreditDebt: isCreditDebt,
      creditDebtAmount: isCreditDebt ? creditBalance.abs() : 0,
    );
  }

  int calculateMonthlyAvailable({
    required int monthlyBudget,
    required int spentThisMonth,
    required int upcomingReserved,
  }) {
    return monthlyBudget - spentThisMonth - upcomingReserved;
  }

  int calculateCreditThroughDay({
    required int monthlyBudget,
    required int dayOfMonth,
    required int daysInMonth,
  }) {
    if (monthlyBudget <= 0 || dayOfMonth <= 0 || daysInMonth <= 0) {
      return 0;
    }

    final cappedDay = dayOfMonth.clamp(0, daysInMonth);
    return monthlyBudget * cappedDay ~/ daysInMonth;
  }

  int calculateDailyCredit({
    required int monthlyBudget,
    required int dayOfMonth,
    required int daysInMonth,
  }) {
    if (monthlyBudget <= 0 || dayOfMonth <= 0 || daysInMonth <= 0) {
      return 0;
    }

    return calculateCreditThroughDay(
          monthlyBudget: monthlyBudget,
          dayOfMonth: dayOfMonth,
          daysInMonth: daysInMonth,
        ) -
        calculateCreditThroughDay(
          monthlyBudget: monthlyBudget,
          dayOfMonth: dayOfMonth - 1,
          daysInMonth: daysInMonth,
        );
  }

  double? calculateWishlistImpactDays({
    required int price,
    required int currentDailySafe,
  }) {
    if (price <= 0 || currentDailySafe <= 0) {
      return null;
    }

    return price / currentDailySafe;
  }

  int calculatePostPurchaseDailySafe({
    required int monthlyAvailable,
    required int purchasePrice,
    required int remainingDaysInMonth,
  }) {
    if (remainingDaysInMonth <= 0) {
      return 0;
    }

    final remainingAfterPurchase = monthlyAvailable - purchasePrice;
    if (remainingAfterPurchase <= 0) {
      return 0;
    }

    return remainingAfterPurchase ~/ remainingDaysInMonth;
  }
}
