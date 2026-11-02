import 'package:drift/drift.dart';

import '../../domain/models/category_budget_allocation.dart';
import '../db/app_database.dart';

extension CategoryBudgetAllocationMapper on CategoryBudgetAllocation {
  CategoryBudgetAllocationsTableCompanion toCompanion() {
    return CategoryBudgetAllocationsTableCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      categoryId: Value(categoryId),
      yearMonth: Value(yearMonth),
      budgetAmount: Value(budgetAmount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension CategoryBudgetAllocationDataMapper
    on CategoryBudgetAllocationsTableData {
  CategoryBudgetAllocation toDomain() {
    return CategoryBudgetAllocation(
      id: id,
      categoryId: categoryId,
      yearMonth: yearMonth,
      budgetAmount: budgetAmount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
