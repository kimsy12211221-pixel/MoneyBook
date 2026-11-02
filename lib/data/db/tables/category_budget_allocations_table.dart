import 'package:drift/drift.dart';

import 'categories_table.dart';

class CategoryBudgetAllocationsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(CategoriesTable, #id)();
  TextColumn get yearMonth => text()();
  IntColumn get budgetAmount => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {categoryId, yearMonth},
      ];
}
