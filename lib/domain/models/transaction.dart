import '../../core/types/enums.dart';

class SpendingTransaction {
  const SpendingTransaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.budgetType,
    required this.specialCategory,
    required this.categoryId,
    required this.occurredAt,
    required this.memo,
    required this.source,
    required this.linkedUpcomingExpenseId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    this.paymentMethod = PaymentMethod.cash,
    this.prepaidAt,
  });

  final int id;
  final int amount;
  final TransactionType type;
  final BudgetType budgetType;
  final SpecialCategory? specialCategory;
  final int? categoryId;
  final DateTime occurredAt;
  final String? memo;
  final String source;
  final int? linkedUpcomingExpenseId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final PaymentMethod paymentMethod;
  final DateTime? prepaidAt;
}
