import 'package:drift/drift.dart';

import '../../domain/models/budget.dart';
import '../../domain/repositories/budget_repository.dart';
import '../db/app_database.dart';
import '../mappers/budget_mapper.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  const BudgetRepositoryImpl(this._database);

  final AppDatabase _database;

  @override
  Future<Budget?> getBudgetForMonth(String yearMonth) async {
    final query = _database.select(_database.budgetsTable)
      ..where((tbl) => tbl.effectiveMonth.equals(yearMonth))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.updatedAt)])
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Future<void> upsertBudget(Budget budget) async {
    final existingRows = await (_database.select(_database.budgetsTable)
          ..where((tbl) => tbl.effectiveMonth.equals(budget.effectiveMonth))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.updatedAt)])
          ..limit(1))
        .get();
    final existing = existingRows.isEmpty ? null : existingRows.first;
    await _database.into(_database.budgetsTable).insert(
          budget.toCompanion().copyWith(
                id: existing == null
                    ? const Value.absent()
                    : Value(existing.id),
              ),
          mode: InsertMode.insertOrReplace,
        );
  }

  @override
  Stream<Budget?> watchBudgetForMonth(String yearMonth) {
    final query = _database.select(_database.budgetsTable)
      ..where((tbl) => tbl.effectiveMonth.equals(yearMonth))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.updatedAt)])
      ..limit(1);
    return query.watch().map(
          (rows) => rows.isEmpty ? null : rows.first.toDomain(),
        );
  }
}
