class MonthlySummary {
  const MonthlySummary({
    required this.yearMonth,
    required this.totalSpent,
    required this.notSpent,
    required this.biggestCategory,
    required this.impulseBuysKilled,
    required this.averageDailySpend,
    required this.averageCalendarDailySpend,
    required this.elapsedDays,
    required this.totalTransactions,
    required this.spendingDays,
    required this.averageTransactionAmount,
    required this.highestSpendDate,
    required this.highestSpendAmount,
    required this.categoryBreakdown,
  });

  final String yearMonth;
  final int totalSpent;
  final int notSpent;
  final String biggestCategory;
  final int impulseBuysKilled;

  /// Average only across days which had at least one payment.
  final int averageDailySpend;

  /// Month-to-date pace, including no-spend days.
  final int averageCalendarDailySpend;
  final int elapsedDays;
  final int totalTransactions;
  final int spendingDays;
  final int averageTransactionAmount;
  final DateTime? highestSpendDate;
  final int highestSpendAmount;
  final List<CategorySpend> categoryBreakdown;
}

class CategorySpend {
  const CategorySpend({
    required this.categoryId,
    required this.name,
    required this.amount,
  });

  final int categoryId;
  final String name;
  final int amount;
}
