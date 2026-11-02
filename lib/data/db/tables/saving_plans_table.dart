import 'package:drift/drift.dart';

class SavingPlansTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get yearMonth => text()();
  IntColumn get salaryAmount => integer()();
  TextColumn get etfLabel =>
      text().withDefault(const Constant('신한투자 / ETF투자'))();
  IntColumn get etfTarget => integer()();
  TextColumn get annualSpecialLabel =>
      text().withDefault(const Constant('토스나눠모으기 / ANNUAL SPECIAL'))();
  IntColumn get annualSpecialTarget => integer()();
  TextColumn get livingLabel =>
      text().withDefault(const Constant('케이뱅크 / 생활비이체'))();
  IntColumn get livingBudgetTarget => integer()();
  TextColumn get housingLabel =>
      text().withDefault(const Constant('토스나눠모으기 / 비상금'))();
  IntColumn get housingTarget => integer()();
  TextColumn get fixedCostLabel =>
      text().withDefault(const Constant('토스통장 / 고정비확보'))();
  IntColumn get fixedCostTarget => integer()();
  DateTimeColumn get etfDoneAt => dateTime().nullable()();
  DateTimeColumn get annualSpecialDoneAt => dateTime().nullable()();
  DateTimeColumn get livingDoneAt => dateTime().nullable()();
  DateTimeColumn get housingDoneAt => dateTime().nullable()();
  DateTimeColumn get fixedCostDoneAt => dateTime().nullable()();
  IntColumn get sweepAmount => integer().nullable()();
  DateTimeColumn get sweptAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {yearMonth},
      ];
}
