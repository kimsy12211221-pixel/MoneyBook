import '../models/annual_special_budget.dart';

abstract class AnnualSpecialBudgetRepository {
  Stream<AnnualSpecialBudget?> watchForYear(int year);
  Future<void> upsert(AnnualSpecialBudget budget);
}
