import 'package:drift/drift.dart';

import '../../domain/models/budget.dart';
import '../db/app_database.dart';

extension BudgetMapper on Budget {
  BudgetsTableCompanion toCompanion() {
    return BudgetsTableCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      monthlyBudget: Value(monthlyBudget),
      currencyCode: Value(currencyCode),
      effectiveMonth: Value(effectiveMonth),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension BudgetDataMapper on BudgetsTableData {
  Budget toDomain() {
    return Budget(
      id: id,
      monthlyBudget: monthlyBudget,
      currencyCode: currencyCode,
      effectiveMonth: effectiveMonth,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
