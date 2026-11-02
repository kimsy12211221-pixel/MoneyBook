import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/date_range_utils.dart';
import '../models/upcoming_expense.dart';
import 'current_date_provider.dart';
import 'repositories_provider.dart';

final upcomingExpensesProvider = StreamProvider<List<UpcomingExpense>>((ref) {
  return ref.watch(upcomingExpenseRepositoryProvider).watchUpcomingExpenses();
});

final currentMonthUpcomingReservedProvider = Provider<int>((ref) {
  final items = ref.watch(upcomingExpensesProvider).valueOrNull ??
      const <UpcomingExpense>[];
  final now = ref.watch(currentDateProvider).valueOrNull ?? DateTime.now();
  final yearMonth = DateRangeUtils.yearMonthKey(now);
  return items
      .where(
        (item) =>
            DateRangeUtils.yearMonthKey(item.scheduledDate) == yearMonth &&
            item.isPaid == false,
      )
      .fold<int>(0, (sum, item) => sum + item.amount);
});
