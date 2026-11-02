import 'package:drift/drift.dart';

class CategoriesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get icon => text().withDefault(const Constant('circle'))();
  TextColumn get description => text().nullable()();
  TextColumn get colorToken => text().nullable()();
  IntColumn get sortOrder => integer()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {name},
      ];
}
