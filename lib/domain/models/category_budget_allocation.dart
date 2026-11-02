class CategoryBudgetAllocation {
  const CategoryBudgetAllocation({
    required this.id,
    required this.categoryId,
    required this.yearMonth,
    required this.budgetAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int categoryId;
  final String yearMonth;
  final int budgetAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
}
