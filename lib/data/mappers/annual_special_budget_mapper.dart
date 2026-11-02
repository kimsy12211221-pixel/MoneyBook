import 'package:drift/drift.dart';

import '../../domain/models/annual_special_budget.dart';
import '../db/app_database.dart';

extension AnnualSpecialBudgetMapper on AnnualSpecialBudget {
  AnnualSpecialBudgetsTableCompanion toCompanion() {
    return AnnualSpecialBudgetsTableCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      year: Value(year),
      budgetAmount: Value(budgetAmount),
      currencyCode: Value(currencyCode),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension AnnualSpecialBudgetDataMapper on AnnualSpecialBudgetsTableData {
  AnnualSpecialBudget toDomain() {
    return AnnualSpecialBudget(
      id: id,
      year: year,
      budgetAmount: budgetAmount,
      currencyCode: currencyCode,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
