import '../../core/types/enums.dart';

class AnnualSpecialSnapshot {
  const AnnualSpecialSnapshot({
    required this.year,
    required this.budgetAmount,
    required this.spentAmount,
    required this.spentByCategory,
  });

  final int year;
  final int budgetAmount;
  final int spentAmount;
  final Map<SpecialCategory, int> spentByCategory;

  int get remainingAmount => budgetAmount - spentAmount;
}
