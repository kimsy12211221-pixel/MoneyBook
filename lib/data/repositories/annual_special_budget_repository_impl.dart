import 'package:drift/drift.dart';

import '../../domain/models/annual_special_budget.dart';
import '../../domain/repositories/annual_special_budget_repository.dart';
import '../db/app_database.dart';
import '../mappers/annual_special_budget_mapper.dart';

class AnnualSpecialBudgetRepositoryImpl
    implements AnnualSpecialBudgetRepository {
  const AnnualSpecialBudgetRepositoryImpl(this._database);

  final AppDatabase _database;

  @override
  Future<void> upsert(AnnualSpecialBudget budget) async {
    final query = _database.select(_database.annualSpecialBudgetsTable)
      ..where((table) => table.year.equals(budget.year))
      ..orderBy([(table) => OrderingTerm.desc(table.updatedAt)])
      ..limit(1);
    final existing = await query.getSingleOrNull();
    await _database.into(_database.annualSpecialBudgetsTable).insert(
          budget.toCompanion().copyWith(
                id: existing == null
                    ? const Value.absent()
                    : Value(existing.id),
              ),
          mode: InsertMode.insertOrReplace,
        );
  }

  @override
  Stream<AnnualSpecialBudget?> watchForYear(int year) {
    final query = _database.select(_database.annualSpecialBudgetsTable)
      ..where((table) => table.year.equals(year))
      ..orderBy([(table) => OrderingTerm.desc(table.updatedAt)])
      ..limit(1);
    return query.watch().map(
          (rows) => rows.isEmpty ? null : rows.first.toDomain(),
        );
  }
}
