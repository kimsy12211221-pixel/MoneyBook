import 'package:flutter_test/flutter_test.dart';
import 'package:personal_spending_app/core/types/enums.dart';
import 'package:personal_spending_app/domain/models/category.dart';
import 'package:personal_spending_app/domain/models/transaction.dart';
import 'package:personal_spending_app/domain/models/wishlist_item.dart';
import 'package:personal_spending_app/domain/services/monthly_summary_service.dart';

void main() {
  const service = MonthlySummaryService();

  test('calculates spent, not spent, biggest category, and average daily spend',
      () {
    final summary = service.calculate(
      yearMonth: '2026-08',
      asOf: DateTime(2026, 8, 31),
      transactions: [
        SpendingTransaction(
          id: 1,
          amount: 24000,
          type: TransactionType.expense,
          budgetType: BudgetType.monthly,
          specialCategory: null,
          categoryId: 1,
          occurredAt: DateTime(2026, 8, 30),
          memo: 'DINNER',
          source: 'manual',
          linkedUpcomingExpenseId: null,
          createdAt: DateTime(2026, 8, 30),
          updatedAt: DateTime(2026, 8, 30),
          deletedAt: null,
        ),
        SpendingTransaction(
          id: 2,
          amount: 5800,
          type: TransactionType.expense,
          budgetType: BudgetType.monthly,
          specialCategory: null,
          categoryId: 2,
          occurredAt: DateTime(2026, 8, 31),
          memo: 'COFFEE',
          source: 'manual',
          linkedUpcomingExpenseId: null,
          createdAt: DateTime(2026, 8, 31),
          updatedAt: DateTime(2026, 8, 31),
          deletedAt: null,
        ),
      ],
      wishlistItems: [
        WishlistItem(
          id: 1,
          name: 'SNEAKERS',
          price: 189000,
          url: null,
          imagePath: null,
          memo: null,
          cooldownHours: 72,
          createdAt: DateTime(2026, 8, 28),
          cooldownUntil: DateTime(2026, 8, 31),
          status: WishlistStatus.letGo,
          waitingUntil: null,
          purchasedAt: null,
          releasedAt: DateTime(2026, 8, 31),
          linkedTransactionId: null,
          createdDailySafeSnapshot: 42000,
          updatedAt: DateTime(2026, 8, 31),
        ),
      ],
      categories: [
        Category(
          id: 1,
          name: 'FOOD',
          icon: 'restaurant',
          colorToken: null,
          sortOrder: 0,
          isActive: true,
          isDefault: true,
          createdAt: DateTime(2026, 8, 1),
          updatedAt: DateTime(2026, 8, 1),
        ),
        Category(
          id: 2,
          name: 'CAFE',
          icon: 'coffee',
          colorToken: null,
          sortOrder: 1,
          isActive: true,
          isDefault: true,
          createdAt: DateTime(2026, 8, 1),
          updatedAt: DateTime(2026, 8, 1),
        ),
      ],
    );

    expect(summary.totalSpent, 29800);
    expect(summary.notSpent, 189000);
    expect(summary.biggestCategory, 'FOOD');
    expect(summary.impulseBuysKilled, 1);
    expect(summary.averageDailySpend, 14900);
    expect(summary.averageCalendarDailySpend, 961);
    expect(summary.elapsedDays, 31);
    expect(summary.totalTransactions, 2);
    expect(summary.spendingDays, 2);
    expect(summary.averageTransactionAmount, 14900);
    expect(summary.highestSpendDate, DateTime(2026, 8, 30));
    expect(summary.highestSpendAmount, 24000);
    expect(summary.categoryBreakdown.first.name, 'FOOD');
    expect(summary.categoryBreakdown.first.categoryId, 1);
    expect(summary.categoryBreakdown.first.amount, 24000);
  });
}
