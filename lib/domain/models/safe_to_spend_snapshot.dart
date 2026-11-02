class SafeToSpendSnapshot {
  const SafeToSpendSnapshot({
    required this.dailySafe,
    required this.weeklySafe,
    required this.monthlySafe,
    required this.monthlyAvailable,
    required this.dailyCredit,
    required this.creditBalance,
    required this.weeklyCreditBalance,
    required this.remainingDaysInMonth,
    required this.remainingDaysInCurrentWeek,
    required this.spentThisMonth,
    required this.upcomingReserved,
    required this.isOverBudget,
    required this.overBudgetAmount,
    required this.isCreditDebt,
    required this.creditDebtAmount,
  });

  final int dailySafe;
  final int weeklySafe;
  final int monthlySafe;
  final int monthlyAvailable;
  final int dailyCredit;
  final int creditBalance;
  final int weeklyCreditBalance;
  final int remainingDaysInMonth;
  final int remainingDaysInCurrentWeek;
  final int spentThisMonth;
  final int upcomingReserved;
  final bool isOverBudget;
  final int overBudgetAmount;
  final bool isCreditDebt;
  final int creditDebtAmount;
}
