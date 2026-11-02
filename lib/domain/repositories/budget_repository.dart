import '../models/budget.dart';

abstract class BudgetRepository {
  Future<Budget?> getBudgetForMonth(String yearMonth);
  Stream<Budget?> watchBudgetForMonth(String yearMonth);
  Future<void> upsertBudget(Budget budget);
}
