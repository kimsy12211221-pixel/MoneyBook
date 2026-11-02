import 'package:drift/drift.dart';

import 'categories_table.dart';

class UpcomingExpensesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get amount => integer()();
  DateTimeColumn get scheduledDate => dateTime()();
  IntColumn get categoryId =>
      integer().nullable().references(CategoriesTable, #id)();
  BoolColumn get isRecurring => boolean().withDefault(const Constant(false))();
  TextColumn get recurrenceType => text().withDefault(const Constant('none'))();
  IntColumn get recurrenceInterval => integer().nullable()();
  BoolColumn get isPaid => boolean().withDefault(const Constant(false))();
  IntColumn get paidTransactionId => integer().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
