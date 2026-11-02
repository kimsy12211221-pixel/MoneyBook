import 'package:drift/drift.dart';

import 'categories_table.dart';

class TransactionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get amount => integer()();
  TextColumn get type => text()();
  TextColumn get budgetType => text().withDefault(const Constant('monthly'))();
  TextColumn get specialCategory => text().nullable()();
  TextColumn get paymentMethod => text().withDefault(const Constant('cash'))();
  DateTimeColumn get prepaidAt => dateTime().nullable()();
  IntColumn get categoryId =>
      integer().nullable().references(CategoriesTable, #id)();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get memo => text().nullable()();
  TextColumn get source => text().withDefault(const Constant('manual'))();
  IntColumn get linkedUpcomingExpenseId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
