import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/platform/json_file_exporter.dart';
import '../../data/db/app_database.dart';
import 'database_provider.dart';

final maintenanceControllerProvider = Provider<MaintenanceController>((ref) {
  return MaintenanceController(ref.watch(appDatabaseProvider));
});

class MaintenanceController {
  const MaintenanceController(this._database);

  final AppDatabase _database;

  Future<String> exportJson() async {
    final budgets = await _database.select(_database.budgetsTable).get();
    final annualSpecialBudgets =
        await _database.select(_database.annualSpecialBudgetsTable).get();
    final categoryBudgetAllocations =
        await _database.select(_database.categoryBudgetAllocationsTable).get();
    final categories = await _database.select(_database.categoriesTable).get();
    final transactions =
        await _database.select(_database.transactionsTable).get();
    final upcoming =
        await _database.select(_database.upcomingExpensesTable).get();
    final wishlist = await _database.select(_database.wishlistItemsTable).get();
    final wishlistEvents =
        await _database.select(_database.wishlistEventsTable).get();
    final settings = await _database.select(_database.appSettingsTable).get();
    final savingPlans =
        await _database.select(_database.savingPlansTable).get();

    final export = jsonEncode({
      'exportVersion': 2,
      'exportedAt': DateTime.now().toIso8601String(),
      'budgets': budgets.map((item) => item.toJson()).toList(growable: false),
      'annualSpecialBudgets': annualSpecialBudgets
          .map((item) => item.toJson())
          .toList(growable: false),
      'categories':
          categories.map((item) => item.toJson()).toList(growable: false),
      'categoryBudgetAllocations': categoryBudgetAllocations
          .map((item) => item.toJson())
          .toList(growable: false),
      'transactions':
          transactions.map((item) => item.toJson()).toList(growable: false),
      'upcomingExpenses':
          upcoming.map((item) => item.toJson()).toList(growable: false),
      'wishlistItems':
          wishlist.map((item) => item.toJson()).toList(growable: false),
      'wishlistEvents':
          wishlistEvents.map((item) => item.toJson()).toList(growable: false),
      'settings': settings.map((item) => item.toJson()).toList(growable: false),
      'savingPlans':
          savingPlans.map((item) => item.toJson()).toList(growable: false),
    });

    final now = DateTime.now();
    final timestamp = '${now.year}${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}_'
        '${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}'
        '${now.second.toString().padLeft(2, '0')}';
    return JsonFileExporter.saveToDownloads(
      fileName: 'personal_spending_export_$timestamp.json',
      content: export,
    );
  }

  Future<String> exportMonthJson(DateTime month) async {
    final monthStart = DateTime(month.year, month.month);
    final nextMonthStart = DateTime(month.year, month.month + 1);
    final yearMonth =
        '${monthStart.year}-${monthStart.month.toString().padLeft(2, '0')}';
    final transactions = await (_database.select(_database.transactionsTable)
          ..where(
            (table) =>
                table.occurredAt.isBiggerOrEqualValue(monthStart) &
                table.occurredAt.isSmallerThanValue(nextMonthStart),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.occurredAt)]))
        .get();
    final categories = await _database.select(_database.categoriesTable).get();
    final categoryIds =
        transactions.map((item) => item.categoryId).whereType<int>().toSet();
    final referencedCategories = categories
        .where((item) => categoryIds.contains(item.id))
        .toList(growable: false);
    final budget = await (_database.select(_database.budgetsTable)
          ..where((table) => table.effectiveMonth.equals(yearMonth))
          ..orderBy([(table) => OrderingTerm.desc(table.updatedAt)])
          ..limit(1))
        .get();
    final annualSpecialBudget =
        await (_database.select(_database.annualSpecialBudgetsTable)
              ..where((table) => table.year.equals(monthStart.year))
              ..orderBy([(table) => OrderingTerm.desc(table.updatedAt)])
              ..limit(1))
            .get();

    final export = jsonEncode({
      'exportVersion': 2,
      'scope': 'monthly',
      'yearMonth': yearMonth,
      'exportedAt': DateTime.now().toIso8601String(),
      'transactionCount': transactions.length,
      'monthlyBudget': budget.isEmpty ? null : budget.first.toJson(),
      'annualSpecialBudget': annualSpecialBudget.isEmpty
          ? null
          : annualSpecialBudget.first.toJson(),
      'categories': referencedCategories
          .map((item) => item.toJson())
          .toList(growable: false),
      'transactions':
          transactions.map((item) => item.toJson()).toList(growable: false),
    });

    return JsonFileExporter.saveToDownloads(
      fileName: 'personal_spending_$yearMonth.json',
      content: export,
    );
  }

  Future<void> resetData() async {
    await _database.transaction(() async {
      await _database.delete(_database.wishlistEventsTable).go();
      await _database.delete(_database.wishlistItemsTable).go();
      await _database.delete(_database.upcomingExpensesTable).go();
      await _database.delete(_database.transactionsTable).go();
      await _database.delete(_database.categoryBudgetAllocationsTable).go();
      await _database.delete(_database.savingPlansTable).go();
      await _database.delete(_database.annualSpecialBudgetsTable).go();
      await _database.delete(_database.budgetsTable).go();
      await _database.delete(_database.appSettingsTable).go();
      await _database.delete(_database.categoriesTable).go();
    });
  }
}
