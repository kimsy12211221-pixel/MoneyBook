import '../../core/types/enums.dart';

class UpcomingExpense {
  const UpcomingExpense({
    required this.id,
    required this.title,
    required this.amount,
    required this.scheduledDate,
    required this.categoryId,
    required this.isRecurring,
    required this.recurrenceType,
    required this.recurrenceInterval,
    required this.isPaid,
    required this.paidTransactionId,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final int amount;
  final DateTime scheduledDate;
  final int? categoryId;
  final bool isRecurring;
  final UpcomingExpenseRecurrenceType recurrenceType;
  final int? recurrenceInterval;
  final bool isPaid;
  final int? paidTransactionId;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
}
