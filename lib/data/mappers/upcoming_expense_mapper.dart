import 'package:drift/drift.dart';

import '../../core/types/enums.dart';
import '../../domain/models/upcoming_expense.dart';
import '../db/app_database.dart';

extension UpcomingExpenseMapper on UpcomingExpense {
  UpcomingExpensesTableCompanion toCompanion() {
    return UpcomingExpensesTableCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      title: Value(title),
      amount: Value(amount),
      scheduledDate: Value(scheduledDate),
      categoryId: Value(categoryId),
      isRecurring: Value(isRecurring),
      recurrenceType: Value(recurrenceType.name),
      recurrenceInterval: Value(recurrenceInterval),
      isPaid: Value(isPaid),
      paidTransactionId: Value(paidTransactionId),
      note: Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension UpcomingExpenseDataMapper on UpcomingExpensesTableData {
  UpcomingExpense toDomain() {
    final parsedType = UpcomingExpenseRecurrenceType.values.firstWhere(
      (item) => item.name == recurrenceType,
      orElse: () => UpcomingExpenseRecurrenceType.none,
    );

    return UpcomingExpense(
      id: id,
      title: title,
      amount: amount,
      scheduledDate: scheduledDate,
      categoryId: categoryId,
      isRecurring: isRecurring,
      recurrenceType: parsedType,
      recurrenceInterval: recurrenceInterval,
      isPaid: isPaid,
      paidTransactionId: paidTransactionId,
      note: note,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
