import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_settings_keys.dart';
import '../../../core/utils/date_range_utils.dart';
import '../../../domain/models/budget.dart';
import '../../../domain/providers/repositories_provider.dart';

final completeOnboardingProvider =
    FutureProvider.family<void, int>((ref, monthlyBudget) async {
  final now = DateTime.now();
  final yearMonth = DateRangeUtils.yearMonthKey(now);
  final budgetRepository = ref.watch(budgetRepositoryProvider);
  final appSettingsRepository = ref.watch(appSettingsRepositoryProvider);
  final categoryRepository = ref.watch(categoryRepositoryProvider);

  await categoryRepository.seedDefaultCategoriesIfNeeded();
  await budgetRepository.upsertBudget(
    Budget(
      id: 0,
      monthlyBudget: monthlyBudget,
      currencyCode: 'KRW',
      effectiveMonth: yearMonth,
      createdAt: now,
      updatedAt: now,
    ),
  );
  await appSettingsRepository.setSetting(
      AppSettingsKeys.setupCompleted, 'true');
  await appSettingsRepository.setSetting(
      AppSettingsKeys.defaultCurrency, 'KRW');
});
