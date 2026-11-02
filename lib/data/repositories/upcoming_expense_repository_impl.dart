import 'package:drift/drift.dart';

import '../../core/utils/date_range_utils.dart';
import '../../domain/models/upcoming_expense.dart';
import '../../domain/repositories/upcoming_expense_repository.dart';
import '../db/app_database.dart';
import '../mappers/upcoming_expense_mapper.dart';

class UpcomingExpenseRepositoryImpl implements UpcomingExpenseRepository {
  const UpcomingExpenseRepositoryImpl(this._database);

  final AppDatabase _database;

  @override
  Future<void> createUpcomingExpense(UpcomingExpense item) async {
    await _database
        .into(_database.upcomingExpensesTable)
        .insert(item.toCompanion());
  }

  @override
  Future<void> markAsPaid(int id, {int? linkedTransactionId}) async {
    await (_database.update(_database.upcomingExpensesTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(
      UpcomingExpensesTableCompanion(
        isPaid: const Value(true),
        paidTransactionId: Value(linkedTransactionId),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<int> sumReservedForMonth(String yearMonth) async {
    final month = _parseYearMonth(yearMonth);
    final start = DateRangeUtils.startOfMonth(month);
    final end = DateRangeUtils.endOfMonth(month);

    final query = _database.select(_database.upcomingExpensesTable)
      ..where((tbl) =>
          tbl.isPaid.equals(false) &
          tbl.scheduledDate.isBiggerOrEqualValue(start) &
          tbl.scheduledDate.isSmallerOrEqualValue(end));
    final rows = await query.get();
    return rows.fold<int>(0, (sum, item) => sum + item.amount);
  }

  @override
  Stream<List<UpcomingExpense>> watchUpcomingExpenses() {
    final query = _database.select(_database.upcomingExpensesTable)
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.scheduledDate)]);
    return query.watch().map(
          (rows) => rows.map((item) => item.toDomain()).toList(growable: false),
        );
  }

  DateTime _parseYearMonth(String yearMonth) {
    final parts = yearMonth.split('-');
    return DateTime(int.parse(parts[0]), int.parse(parts[1]));
  }
}
