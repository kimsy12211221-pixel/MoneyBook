import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/date_range_utils.dart';
import '../../core/types/enums.dart';
import '../models/transaction.dart';
import 'current_date_provider.dart';
import 'repositories_provider.dart';

final recentTransactionsProvider =
    StreamProvider<List<SpendingTransaction>>((ref) {
  return ref.watch(transactionRepositoryProvider).watchRecentTransactions(5);
});

final currentMonthTransactionsProvider =
    StreamProvider<List<SpendingTransaction>>((ref) {
  final now = ref.watch(currentDateProvider).valueOrNull ?? DateTime.now();
  final yearMonth = DateRangeUtils.yearMonthKey(now);
  return ref
      .watch(transactionRepositoryProvider)
      .watchTransactionsForMonth(yearMonth);
});

/// Used by the log's month navigator. Keeping this separate prevents the log
/// from changing the HOME dashboard's current-month calculations.
final transactionsForMonthProvider =
    StreamProvider.family<List<SpendingTransaction>, String>((ref, yearMonth) {
  return ref
      .watch(transactionRepositoryProvider)
      .watchTransactionsForMonth(yearMonth);
});

final currentMonthExpenseTotalProvider = Provider<AsyncValue<int>>((ref) {
  return ref.watch(currentMonthMonthlyTransactionsProvider).whenData(
        (items) => items.fold<int>(0, (sum, item) => sum + item.amount),
      );
});

final currentMonthMonthlyTransactionsProvider =
    Provider<AsyncValue<List<SpendingTransaction>>>((ref) {
  return ref.watch(currentMonthTransactionsProvider).whenData(
        (items) => items
            .where((item) => item.budgetType == BudgetType.monthly)
            .toList(growable: false),
      );
});

final currentYearAnnualSpecialTransactionsProvider =
    StreamProvider<List<SpendingTransaction>>((ref) {
  final now = ref.watch(currentDateProvider).valueOrNull ?? DateTime.now();
  final year = now.year;
  return ref
      .watch(transactionRepositoryProvider)
      .watchTransactionsForYear(year)
      .map(
        (items) => items
            .where((item) => item.budgetType == BudgetType.annualSpecial)
            .toList(growable: false),
      );
});
