import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/types/enums.dart';
import '../models/annual_special_snapshot.dart';
import 'current_date_provider.dart';
import 'repositories_provider.dart';
import 'transaction_provider.dart';

final currentYearAnnualSpecialBudgetProvider = StreamProvider((ref) {
  final now = ref.watch(currentDateProvider).valueOrNull ?? DateTime.now();
  return ref
      .watch(annualSpecialBudgetRepositoryProvider)
      .watchForYear(now.year);
});

final annualSpecialSnapshotProvider =
    Provider<AsyncValue<AnnualSpecialSnapshot?>>((ref) {
  final budgetAsync = ref.watch(currentYearAnnualSpecialBudgetProvider);
  final transactionsAsync =
      ref.watch(currentYearAnnualSpecialTransactionsProvider);

  return budgetAsync.whenData((budget) {
    if (budget == null) {
      return null;
    }
    final transactions = transactionsAsync.valueOrNull;
    if (transactions == null) {
      return null;
    }
    final spentByCategory = <SpecialCategory, int>{};
    for (final transaction in transactions) {
      final category = transaction.specialCategory;
      if (category != null) {
        spentByCategory[category] =
            (spentByCategory[category] ?? 0) + transaction.amount;
      }
    }
    return AnnualSpecialSnapshot(
      year: budget.year,
      budgetAmount: budget.budgetAmount,
      spentAmount: transactions.fold<int>(0, (sum, item) => sum + item.amount),
      spentByCategory: spentByCategory,
    );
  });
});
