import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/date_range_utils.dart';
import '../models/monthly_summary.dart';
import '../services/monthly_summary_service.dart';
import 'category_provider.dart';
import 'current_date_provider.dart';
import 'transaction_provider.dart';
import 'wishlist_provider.dart';

final monthlySummaryServiceProvider = Provider<MonthlySummaryService>((ref) {
  return const MonthlySummaryService();
});

final currentMonthSummaryProvider = Provider<MonthlySummary?>((ref) {
  final transactions =
      ref.watch(currentMonthMonthlyTransactionsProvider).valueOrNull;
  final categories = ref.watch(activeCategoriesProvider).valueOrNull;
  final wishlistItems = ref.watch(allWishlistItemsProvider).valueOrNull;
  final notSpent = ref.watch(currentMonthNotSpentProvider);

  if (transactions == null || categories == null || wishlistItems == null) {
    return null;
  }

  final service = ref.watch(monthlySummaryServiceProvider);
  final now = ref.watch(currentDateProvider).valueOrNull ?? DateTime.now();
  final currentYearMonth = DateRangeUtils.yearMonthKey(now);
  final summary = service.calculate(
    yearMonth: currentYearMonth,
    asOf: now,
    transactions: transactions,
    wishlistItems: wishlistItems
        .where(
          (item) =>
              item.releasedAt != null &&
              DateRangeUtils.yearMonthKey(item.releasedAt!) == currentYearMonth,
        )
        .toList(growable: false),
    categories: categories,
  );

  return MonthlySummary(
    yearMonth: summary.yearMonth,
    totalSpent: summary.totalSpent,
    notSpent: notSpent,
    biggestCategory: summary.biggestCategory,
    impulseBuysKilled: summary.impulseBuysKilled,
    averageDailySpend: summary.averageDailySpend,
    averageCalendarDailySpend: summary.averageCalendarDailySpend,
    elapsedDays: summary.elapsedDays,
    totalTransactions: summary.totalTransactions,
    spendingDays: summary.spendingDays,
    averageTransactionAmount: summary.averageTransactionAmount,
    highestSpendDate: summary.highestSpendDate,
    highestSpendAmount: summary.highestSpendAmount,
    categoryBreakdown: summary.categoryBreakdown,
  );
});
