import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/date_range_utils.dart';
import '../models/category_budget_allocation.dart';
import 'current_date_provider.dart';
import 'repositories_provider.dart';

final currentMonthCategoryBudgetsProvider =
    StreamProvider<List<CategoryBudgetAllocation>>((ref) {
  final now = ref.watch(currentDateProvider).valueOrNull ?? DateTime.now();
  final month = DateRangeUtils.yearMonthKey(now);
  return ref
      .watch(categoryBudgetAllocationRepositoryProvider)
      .watchForMonth(month);
});
