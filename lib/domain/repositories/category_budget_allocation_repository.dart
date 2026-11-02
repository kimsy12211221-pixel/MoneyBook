import '../models/category_budget_allocation.dart';

abstract class CategoryBudgetAllocationRepository {
  Stream<List<CategoryBudgetAllocation>> watchForMonth(String yearMonth);
  Future<void> upsert(CategoryBudgetAllocation allocation);
  Future<void> replaceForMonth(
    String yearMonth,
    List<CategoryBudgetAllocation> allocations,
  );
}
