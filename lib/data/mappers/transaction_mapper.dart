import 'package:drift/drift.dart';

import '../../core/types/enums.dart';
import '../../domain/models/transaction.dart';
import '../db/app_database.dart';

extension SpendingTransactionMapper on SpendingTransaction {
  TransactionsTableCompanion toCompanion() {
    return TransactionsTableCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      amount: Value(amount),
      type: Value(type.name),
      budgetType: Value(budgetType.name),
      specialCategory: Value(specialCategory?.name),
      paymentMethod: Value(paymentMethod.name),
      prepaidAt: Value(prepaidAt),
      categoryId: Value(categoryId),
      occurredAt: Value(occurredAt),
      memo: Value(memo),
      source: Value(source),
      linkedUpcomingExpenseId: Value(linkedUpcomingExpenseId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: Value(deletedAt),
    );
  }
}

extension TransactionDataMapper on TransactionsTableData {
  SpendingTransaction toDomain() {
    return SpendingTransaction(
      id: id,
      amount: amount,
      type: type == TransactionType.income.name
          ? TransactionType.income
          : TransactionType.expense,
      budgetType: budgetType == BudgetType.annualSpecial.name
          ? BudgetType.annualSpecial
          : BudgetType.monthly,
      specialCategory: SpecialCategory.values
          .where(
            (item) => item.name == specialCategory,
          )
          .firstOrNull,
      paymentMethod: paymentMethod == PaymentMethod.creditCard.name
          ? PaymentMethod.creditCard
          : PaymentMethod.cash,
      prepaidAt: prepaidAt,
      categoryId: categoryId,
      occurredAt: occurredAt,
      memo: memo,
      source: source,
      linkedUpcomingExpenseId: linkedUpcomingExpenseId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}
