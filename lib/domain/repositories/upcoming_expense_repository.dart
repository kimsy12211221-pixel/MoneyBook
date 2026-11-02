import '../models/upcoming_expense.dart';

abstract class UpcomingExpenseRepository {
  Future<void> createUpcomingExpense(UpcomingExpense item);
  Future<void> markAsPaid(int id, {int? linkedTransactionId});
  Stream<List<UpcomingExpense>> watchUpcomingExpenses();
  Future<int> sumReservedForMonth(String yearMonth);
}
