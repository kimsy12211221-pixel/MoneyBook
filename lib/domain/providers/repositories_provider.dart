import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/app_settings_repository_impl.dart';
import '../../data/repositories/annual_special_budget_repository_impl.dart';
import '../../data/repositories/budget_repository_impl.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../data/repositories/category_budget_allocation_repository_impl.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../data/repositories/upcoming_expense_repository_impl.dart';
import '../../data/repositories/wishlist_repository_impl.dart';
import '../repositories/app_settings_repository.dart';
import '../repositories/annual_special_budget_repository.dart';
import '../repositories/budget_repository.dart';
import '../repositories/category_repository.dart';
import '../repositories/category_budget_allocation_repository.dart';
import '../repositories/transaction_repository.dart';
import '../services/category_budget_import_service.dart';
import '../repositories/upcoming_expense_repository.dart';
import '../repositories/wishlist_repository.dart';
import 'database_provider.dart';

final appSettingsRepositoryProvider = Provider<AppSettingsRepository>((ref) {
  return AppSettingsRepositoryImpl(ref.watch(appDatabaseProvider));
});

final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  return BudgetRepositoryImpl(ref.watch(appDatabaseProvider));
});

final annualSpecialBudgetRepositoryProvider =
    Provider<AnnualSpecialBudgetRepository>((ref) {
  return AnnualSpecialBudgetRepositoryImpl(ref.watch(appDatabaseProvider));
});

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepositoryImpl(ref.watch(appDatabaseProvider));
});

final categoryBudgetAllocationRepositoryProvider =
    Provider<CategoryBudgetAllocationRepository>((ref) {
  return CategoryBudgetAllocationRepositoryImpl(
    ref.watch(appDatabaseProvider),
  );
});

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepositoryImpl(ref.watch(appDatabaseProvider));
});

final upcomingExpenseRepositoryProvider =
    Provider<UpcomingExpenseRepository>((ref) {
  return UpcomingExpenseRepositoryImpl(ref.watch(appDatabaseProvider));
});

final wishlistRepositoryProvider = Provider<WishlistRepository>((ref) {
  return WishlistRepositoryImpl(ref.watch(appDatabaseProvider));
});

final categoryBudgetImportServiceProvider =
    Provider<CategoryBudgetImportService>((ref) {
  return CategoryBudgetImportService(
    categoryRepository: ref.watch(categoryRepositoryProvider),
    allocationRepository: ref.watch(categoryBudgetAllocationRepositoryProvider),
    budgetRepository: ref.watch(budgetRepositoryProvider),
    transactionRepository: ref.watch(transactionRepositoryProvider),
  );
});
