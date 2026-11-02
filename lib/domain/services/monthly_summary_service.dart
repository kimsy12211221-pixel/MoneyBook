import '../models/category.dart';
import '../models/monthly_summary.dart';
import '../models/transaction.dart';
import '../models/wishlist_item.dart';

class MonthlySummaryService {
  const MonthlySummaryService();

  MonthlySummary calculate({
    required String yearMonth,
    required DateTime asOf,
    required List<SpendingTransaction> transactions,
    required List<WishlistItem> wishlistItems,
    required List<Category> categories,
  }) {
    final expenseTransactions =
        transactions.where((item) => item.deletedAt == null).toList();
    final totalSpent =
        expenseTransactions.fold<int>(0, (sum, item) => sum + item.amount);
    final notSpent = wishlistItems
        .where((item) => item.releasedAt != null)
        .fold<int>(0, (sum, item) => sum + item.price);
    final impulseBuysKilled =
        wishlistItems.where((item) => item.releasedAt != null).length;

    final categoryNames = {
      for (final category in categories) category.id: category.name,
    };
    final categoryTotals = <int, int>{};
    for (final transaction in expenseTransactions) {
      final categoryId = transaction.categoryId;
      if (categoryId == null) {
        continue;
      }
      categoryTotals.update(categoryId, (value) => value + transaction.amount,
          ifAbsent: () => transaction.amount);
    }

    String biggestCategory = 'NONE';
    var biggestAmount = 0;
    categoryTotals.forEach((categoryId, amount) {
      if (amount > biggestAmount) {
        biggestAmount = amount;
        biggestCategory = categoryNames[categoryId] ?? 'ETC';
      }
    });

    final uniqueDays = expenseTransactions
        .map((item) =>
            '${item.occurredAt.year}-${item.occurredAt.month}-${item.occurredAt.day}')
        .toSet()
        .length;
    final averageDailySpend = uniqueDays == 0 ? 0 : (totalSpent ~/ uniqueDays);
    final monthStart = DateTime(asOf.year, asOf.month);
    final isCurrentMonth =
        yearMonth == '${asOf.year}-${asOf.month.toString().padLeft(2, '0')}';
    final elapsedDays = isCurrentMonth
        ? asOf.day
        : DateTime(monthStart.year, monthStart.month + 1, 0).day;
    final averageCalendarDailySpend =
        elapsedDays == 0 ? 0 : totalSpent ~/ elapsedDays;
    final averageTransactionAmount = expenseTransactions.isEmpty
        ? 0
        : totalSpent ~/ expenseTransactions.length;
    final dailyTotals = <DateTime, int>{};
    for (final transaction in expenseTransactions) {
      final date = DateTime(
        transaction.occurredAt.year,
        transaction.occurredAt.month,
        transaction.occurredAt.day,
      );
      dailyTotals[date] = (dailyTotals[date] ?? 0) + transaction.amount;
    }
    DateTime? highestSpendDate;
    var highestSpendAmount = 0;
    dailyTotals.forEach((date, amount) {
      if (amount > highestSpendAmount) {
        highestSpendDate = date;
        highestSpendAmount = amount;
      }
    });
    final categoryBreakdown = categoryTotals.entries
        .map(
          (entry) => CategorySpend(
            categoryId: entry.key,
            name: categoryNames[entry.key] ?? 'ETC',
            amount: entry.value,
          ),
        )
        .toList()
      ..sort((a, b) => b.amount.compareTo(a.amount));

    return MonthlySummary(
      yearMonth: yearMonth,
      totalSpent: totalSpent,
      notSpent: notSpent,
      biggestCategory: biggestCategory,
      impulseBuysKilled: impulseBuysKilled,
      averageDailySpend: averageDailySpend,
      averageCalendarDailySpend: averageCalendarDailySpend,
      elapsedDays: elapsedDays,
      totalTransactions: expenseTransactions.length,
      spendingDays: uniqueDays,
      averageTransactionAmount: averageTransactionAmount,
      highestSpendDate: highestSpendDate,
      highestSpendAmount: highestSpendAmount,
      categoryBreakdown: categoryBreakdown,
    );
  }
}
