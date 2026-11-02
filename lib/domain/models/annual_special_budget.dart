class AnnualSpecialBudget {
  const AnnualSpecialBudget({
    required this.id,
    required this.year,
    required this.budgetAmount,
    required this.currencyCode,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int year;
  final int budgetAmount;
  final String currencyCode;
  final DateTime createdAt;
  final DateTime updatedAt;
}
