import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/types/enums.dart';
import '../../core/utils/date_range_utils.dart';
import '../../data/db/app_database.dart';
import '../models/transaction.dart';
import 'current_date_provider.dart';
import 'database_provider.dart';
import 'repositories_provider.dart';

enum SavingPlanStep { etf, annualSpecial, living, housing, fixedCost }

enum SavingPlanTarget { salary, etf, annualSpecial, living, housing, fixedCost }

final currentSavingPlanProvider = StreamProvider<SavingPlansTableData?>((ref) {
  final now = ref.watch(currentDateProvider).valueOrNull ?? DateTime.now();
  final yearMonth = DateRangeUtils.yearMonthKey(now);
  final database = ref.watch(appDatabaseProvider);
  final query = database.select(database.savingPlansTable)
    ..where((table) => table.yearMonth.equals(yearMonth));
  return query.watchSingleOrNull();
});

final savingPlanControllerProvider = Provider<SavingPlanController>((ref) {
  return SavingPlanController(
    ref.watch(appDatabaseProvider),
    ref.watch(transactionRepositoryProvider),
  );
});

class SavingPlanController {
  const SavingPlanController(this._database, this._transactions);

  final AppDatabase _database;
  final dynamic _transactions;

  Future<void> ensurePlan(DateTime date) async {
    final yearMonth = DateRangeUtils.yearMonthKey(date);
    final existing = await (_database.select(_database.savingPlansTable)
          ..where((table) => table.yearMonth.equals(yearMonth)))
        .getSingleOrNull();
    if (existing != null) return;
    await _database.into(_database.savingPlansTable).insert(
          _defaultPlan(yearMonth, date),
          mode: InsertMode.insertOrIgnore,
        );
  }

  Future<void> markStepDone(DateTime date, SavingPlanStep step) async {
    await ensurePlan(date);
    final yearMonth = DateRangeUtils.yearMonthKey(date);
    final now = DateTime.now();
    final companion = switch (step) {
      SavingPlanStep.etf =>
        SavingPlansTableCompanion(etfDoneAt: Value(now), updatedAt: Value(now)),
      SavingPlanStep.annualSpecial => SavingPlansTableCompanion(
          annualSpecialDoneAt: Value(now),
          updatedAt: Value(now),
        ),
      SavingPlanStep.living => SavingPlansTableCompanion(
          livingDoneAt: Value(now),
          updatedAt: Value(now),
        ),
      SavingPlanStep.housing => SavingPlansTableCompanion(
          housingDoneAt: Value(now),
          updatedAt: Value(now),
        ),
      SavingPlanStep.fixedCost => SavingPlansTableCompanion(
          fixedCostDoneAt: Value(now),
          updatedAt: Value(now),
        ),
    };
    await (_database.update(_database.savingPlansTable)
          ..where((table) => table.yearMonth.equals(yearMonth)))
        .write(companion);
  }

  Future<void> sweep(DateTime date, int amount) async {
    if (amount <= 0) return;
    await ensurePlan(date);
    final now = DateTime.now();
    final yearMonth = DateRangeUtils.yearMonthKey(date);
    await (_database.update(_database.savingPlansTable)
          ..where((table) => table.yearMonth.equals(yearMonth)))
        .write(
      SavingPlansTableCompanion(
        sweepAmount: Value(amount),
        sweptAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> updateTarget(
    DateTime date,
    SavingPlanTarget target,
    int amount,
  ) async {
    if (amount < 0) return;
    await ensurePlan(date);
    final yearMonth = DateRangeUtils.yearMonthKey(date);
    final now = DateTime.now();
    final companion = switch (target) {
      SavingPlanTarget.salary => SavingPlansTableCompanion(
          salaryAmount: Value(amount), updatedAt: Value(now)),
      SavingPlanTarget.etf => SavingPlansTableCompanion(
          etfTarget: Value(amount), updatedAt: Value(now)),
      SavingPlanTarget.annualSpecial => SavingPlansTableCompanion(
          annualSpecialTarget: Value(amount),
          updatedAt: Value(now),
        ),
      SavingPlanTarget.living => SavingPlansTableCompanion(
          livingBudgetTarget: Value(amount),
          updatedAt: Value(now),
        ),
      SavingPlanTarget.housing => SavingPlansTableCompanion(
          housingTarget: Value(amount),
          updatedAt: Value(now),
        ),
      SavingPlanTarget.fixedCost => SavingPlansTableCompanion(
          fixedCostTarget: Value(amount),
          updatedAt: Value(now),
        ),
    };
    await (_database.update(_database.savingPlansTable)
          ..where((table) => table.yearMonth.equals(yearMonth)))
        .write(companion);
  }

  Future<void> updateLabel(
    DateTime date,
    SavingPlanStep step,
    String label,
  ) async {
    final trimmed = label.trim();
    if (trimmed.isEmpty) return;
    await ensurePlan(date);
    final yearMonth = DateRangeUtils.yearMonthKey(date);
    final now = DateTime.now();
    final companion = switch (step) {
      SavingPlanStep.etf => SavingPlansTableCompanion(
          etfLabel: Value(trimmed),
          updatedAt: Value(now),
        ),
      SavingPlanStep.annualSpecial => SavingPlansTableCompanion(
          annualSpecialLabel: Value(trimmed),
          updatedAt: Value(now),
        ),
      SavingPlanStep.living => SavingPlansTableCompanion(
          livingLabel: Value(trimmed),
          updatedAt: Value(now),
        ),
      SavingPlanStep.housing => SavingPlansTableCompanion(
          housingLabel: Value(trimmed),
          updatedAt: Value(now),
        ),
      SavingPlanStep.fixedCost => SavingPlansTableCompanion(
          fixedCostLabel: Value(trimmed),
          updatedAt: Value(now),
        ),
    };
    await (_database.update(_database.savingPlansTable)
          ..where((table) => table.yearMonth.equals(yearMonth)))
        .write(companion);
  }

  Future<void> markPrepaid(SpendingTransaction transaction) async {
    await _transactions.updateTransaction(
      SpendingTransaction(
        id: transaction.id,
        amount: transaction.amount,
        type: transaction.type,
        budgetType: transaction.budgetType,
        specialCategory: transaction.specialCategory,
        categoryId: transaction.categoryId,
        occurredAt: transaction.occurredAt,
        memo: transaction.memo,
        source: transaction.source,
        linkedUpcomingExpenseId: transaction.linkedUpcomingExpenseId,
        createdAt: transaction.createdAt,
        updatedAt: DateTime.now(),
        deletedAt: transaction.deletedAt,
        paymentMethod: PaymentMethod.creditCard,
        prepaidAt: DateTime.now(),
      ),
    );
  }

  SavingPlansTableCompanion _defaultPlan(String yearMonth, DateTime now) {
    return SavingPlansTableCompanion.insert(
      yearMonth: yearMonth,
      salaryAmount: 4000000,
      etfLabel: const Value('신한투자 / ETF투자'),
      etfTarget: 1000000,
      annualSpecialLabel: const Value('토스나눠모으기 / ANNUAL SPECIAL'),
      annualSpecialTarget: 330000,
      livingLabel: const Value('케이뱅크 / 생활비이체'),
      livingBudgetTarget: 1200000,
      housingLabel: const Value('토스나눠모으기 / 비상금'),
      housingTarget: 114750,
      fixedCostLabel: const Value('토스통장 / 고정비확보'),
      fixedCostTarget: 1355250,
      createdAt: now,
      updatedAt: now,
    );
  }
}
