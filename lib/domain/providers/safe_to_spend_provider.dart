import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/date_range_utils.dart';
import '../models/safe_to_spend_snapshot.dart';
import '../services/safe_to_spend_service.dart';
import 'budget_provider.dart';
import 'current_date_provider.dart';
import 'transaction_provider.dart';
import 'upcoming_expense_provider.dart';

final safeToSpendServiceProvider = Provider<SafeToSpendService>((ref) {
  return const SafeToSpendService();
});

final safeToSpendSnapshotProvider =
    Provider<AsyncValue<SafeToSpendSnapshot?>>((ref) {
  final budgetAsync = ref.watch(currentMonthBudgetProvider);
  final spentAsync = ref.watch(currentMonthExpenseTotalProvider);
  final upcoming = ref.watch(currentMonthUpcomingReservedProvider);
  final service = ref.watch(safeToSpendServiceProvider);

  return budgetAsync.whenData((budget) {
    if (budget == null) {
      return null;
    }

    final spent = spentAsync.valueOrNull;
    if (spent == null) {
      return null;
    }

    final now =
        ref.watch(currentDateProvider).valueOrNull ?? DateTime.now();
    return service.calculate(
      monthlyBudget: budget.monthlyBudget,
      spentThisMonth: spent,
      upcomingReserved: upcoming,
      now: now,
      remainingDaysInCurrentWeek:
          DateRangeUtils.remainingDaysInWeekWithinMonth(now),
    );
  });
});
