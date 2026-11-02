import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/app_settings_table.dart';
import 'tables/annual_special_budgets_table.dart';
import 'tables/budgets_table.dart';
import 'tables/categories_table.dart';
import 'tables/saving_plans_table.dart';
import 'tables/category_budget_allocations_table.dart';
import 'tables/transactions_table.dart';
import 'tables/upcoming_expenses_table.dart';
import 'tables/wishlist_events_table.dart';
import 'tables/wishlist_items_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    AppSettingsTable,
    AnnualSpecialBudgetsTable,
    BudgetsTable,
    CategoriesTable,
    SavingPlansTable,
    CategoryBudgetAllocationsTable,
    TransactionsTable,
    UpcomingExpensesTable,
    WishlistItemsTable,
    WishlistEventsTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(categoryBudgetAllocationsTable);
          }
          if (from < 3) {
            await m.addColumn(categoriesTable, categoriesTable.description);
          }
          if (from < 4) {
            await m.addColumn(transactionsTable, transactionsTable.budgetType);
            await m.addColumn(
              transactionsTable,
              transactionsTable.specialCategory,
            );
            await m.createTable(annualSpecialBudgetsTable);
          }
          if (from < 5) {
            await m.addColumn(
              transactionsTable,
              transactionsTable.paymentMethod,
            );
            await m.addColumn(transactionsTable, transactionsTable.prepaidAt);
            await m.createTable(savingPlansTable);
          }
          if (from < 6) {
            await m.addColumn(savingPlansTable, savingPlansTable.etfLabel);
            await m.addColumn(
              savingPlansTable,
              savingPlansTable.annualSpecialLabel,
            );
            await m.addColumn(savingPlansTable, savingPlansTable.livingLabel);
            await m.addColumn(savingPlansTable, savingPlansTable.housingLabel);
            await m.addColumn(
                savingPlansTable, savingPlansTable.fixedCostLabel);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'personal_spending_app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
