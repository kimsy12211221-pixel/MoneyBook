import 'package:drift/drift.dart';

import '../../core/utils/date_range_utils.dart';
import '../../domain/models/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../db/app_database.dart';
import '../mappers/transaction_mapper.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  const TransactionRepositoryImpl(this._database);

  final AppDatabase _database;

  @override
  Future<void> createTransaction(SpendingTransaction item) async {
    await _database
        .into(_database.transactionsTable)
        .insert(item.toCompanion());
  }

  @override
  Future<void> deleteTransaction(int id) async {
    final query = _database.delete(_database.transactionsTable)
      ..where((tbl) => tbl.id.equals(id));
    await query.go();
  }

  @override
  Future<int> sumExpensesForMonth(String yearMonth) async {
    final month = _parseYearMonth(yearMonth);
    final start = DateRangeUtils.startOfMonth(month);
    final end = DateRangeUtils.endOfMonth(month);

    final query = _database.select(_database.transactionsTable)
      ..where((tbl) =>
          tbl.type.equals('expense') &
          tbl.deletedAt.isNull() &
          tbl.occurredAt.isBiggerOrEqualValue(start) &
          tbl.occurredAt.isSmallerOrEqualValue(end));
    final rows = await query.get();
    return rows.fold<int>(0, (sum, item) => sum + item.amount);
  }

  @override
  Future<void> updateTransaction(SpendingTransaction item) async {
    await _database
        .update(_database.transactionsTable)
        .replace(item.toCompanion());
  }

  @override
  Stream<List<SpendingTransaction>> watchRecentTransactions(int limit) {
    final query = _database.select(_database.transactionsTable)
      ..where((tbl) => tbl.deletedAt.isNull())
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.occurredAt)])
      ..limit(limit);

    return query.watch().map(
          (rows) => rows.map((item) => item.toDomain()).toList(growable: false),
        );
  }

  @override
  Stream<List<SpendingTransaction>> watchTransactionsForMonth(
      String yearMonth) {
    final month = _parseYearMonth(yearMonth);
    final start = DateRangeUtils.startOfMonth(month);
    final end = DateRangeUtils.endOfMonth(month);

    final query = _database.select(_database.transactionsTable)
      ..where((tbl) =>
          tbl.deletedAt.isNull() &
          tbl.occurredAt.isBiggerOrEqualValue(start) &
          tbl.occurredAt.isSmallerOrEqualValue(end))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.occurredAt)]);

    return query.watch().map(
          (rows) => rows.map((item) => item.toDomain()).toList(growable: false),
        );
  }

  @override
  Stream<List<SpendingTransaction>> watchTransactionsForYear(int year) {
    final start = DateRangeUtils.startOfYear(DateTime(year));
    final end = DateRangeUtils.endOfYear(DateTime(year));
    final query = _database.select(_database.transactionsTable)
      ..where((tbl) =>
          tbl.deletedAt.isNull() &
          tbl.occurredAt.isBiggerOrEqualValue(start) &
          tbl.occurredAt.isSmallerOrEqualValue(end))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.occurredAt)]);
    return query.watch().map(
          (rows) => rows.map((item) => item.toDomain()).toList(growable: false),
        );
  }

  DateTime _parseYearMonth(String yearMonth) {
    final parts = yearMonth.split('-');
    return DateTime(int.parse(parts[0]), int.parse(parts[1]));
  }
}
