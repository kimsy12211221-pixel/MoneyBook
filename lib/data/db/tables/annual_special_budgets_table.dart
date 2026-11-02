import 'package:drift/drift.dart';

class AnnualSpecialBudgetsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get year => integer()();
  IntColumn get budgetAmount => integer()();
  TextColumn get currencyCode => text().withDefault(const Constant('KRW'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {year},
      ];
}
