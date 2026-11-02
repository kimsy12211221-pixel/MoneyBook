import '../models/transaction.dart';

abstract class TransactionRepository {
  Future<void> createTransaction(SpendingTransaction item);
  Future<void> updateTransaction(SpendingTransaction item);
  Future<void> deleteTransaction(int id);
  Stream<List<SpendingTransaction>> watchRecentTransactions(int limit);
  Stream<List<SpendingTransaction>> watchTransactionsForMonth(String yearMonth);
  Stream<List<SpendingTransaction>> watchTransactionsForYear(int year);
  Future<int> sumExpensesForMonth(String yearMonth);
}
