import 'package:drift/drift.dart';

class BudgetsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get monthlyBudget => integer()();
  TextColumn get currencyCode => text().withDefault(const Constant('KRW'))();
  TextColumn get effectiveMonth => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {effectiveMonth},
      ];
}
