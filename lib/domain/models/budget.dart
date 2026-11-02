class Budget {
  const Budget({
    required this.id,
    required this.monthlyBudget,
    required this.currencyCode,
    required this.effectiveMonth,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int monthlyBudget;
  final String currencyCode;
  final String effectiveMonth;
  final DateTime createdAt;
  final DateTime updatedAt;
}
