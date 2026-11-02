import 'package:drift/drift.dart';

import '../../domain/models/category_budget_allocation.dart';
import '../../domain/repositories/category_budget_allocation_repository.dart';
import '../db/app_database.dart';
import '../mappers/category_budget_allocation_mapper.dart';

class CategoryBudgetAllocationRepositoryImpl
    implements CategoryBudgetAllocationRepository {
  const CategoryBudgetAllocationRepositoryImpl(this._database);

  final AppDatabase _database;

  @override
  Stream<List<CategoryBudgetAllocation>> watchForMonth(String yearMonth) {
    final query = _database.select(_database.categoryBudgetAllocationsTable)
      ..where((tbl) => tbl.yearMonth.equals(yearMonth))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.categoryId)]);
    return query.watch().map(
          (rows) => rows.map((row) => row.toDomain()).toList(growable: false),
        );
  }

  @override
  Future<void> upsert(CategoryBudgetAllocation allocation) async {
    await _database.into(_database.categoryBudgetAllocationsTable).insert(
          allocation.toCompanion(),
          mode: InsertMode.insertOrReplace,
        );
  }

  @override
  Future<void> replaceForMonth(
    String yearMonth,
    List<CategoryBudgetAllocation> allocations,
  ) async {
    await _database.transaction(() async {
      await (_database.delete(_database.categoryBudgetAllocationsTable)
            ..where((tbl) => tbl.yearMonth.equals(yearMonth)))
          .go();
      await _database.batch((batch) {
        batch.insertAll(
          _database.categoryBudgetAllocationsTable,
          allocations.map((item) => item.toCompanion()).toList(growable: false),
        );
      });
    });
  }
}
