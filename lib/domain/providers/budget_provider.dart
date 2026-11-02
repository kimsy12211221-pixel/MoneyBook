import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/date_range_utils.dart';
import '../models/budget.dart';
import 'current_date_provider.dart';
import 'repositories_provider.dart';

final currentMonthBudgetProvider = StreamProvider<Budget?>((ref) {
  final now = ref.watch(currentDateProvider).valueOrNull ?? DateTime.now();
  final yearMonth = DateRangeUtils.yearMonthKey(now);
  return ref.watch(budgetRepositoryProvider).watchBudgetForMonth(yearMonth);
});

final currentMonthBudgetAmountProvider = Provider<int?>((ref) {
  final budgetAsync = ref.watch(currentMonthBudgetProvider);
  return budgetAsync.valueOrNull?.monthlyBudget;
});
