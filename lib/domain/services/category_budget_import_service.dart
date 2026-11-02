import '../models/budget.dart';
import '../models/category.dart';
import '../models/category_budget_allocation.dart';
import '../models/transaction.dart';
import '../../core/types/enums.dart';
import '../repositories/budget_repository.dart';
import '../repositories/category_budget_allocation_repository.dart';
import '../repositories/category_repository.dart';
import '../repositories/transaction_repository.dart';
import 'category_budget_import_parser.dart';

class CategoryBudgetImportResult {
  const CategoryBudgetImportResult({
    required this.budgetCount,
    required this.transactionCount,
    required this.totalBudget,
  });

  final int budgetCount;
  final int transactionCount;
  final int totalBudget;
}

class CategoryBudgetImportService {
  CategoryBudgetImportService({
    required CategoryRepository categoryRepository,
    required CategoryBudgetAllocationRepository allocationRepository,
    required BudgetRepository budgetRepository,
    required TransactionRepository transactionRepository,
    CategoryBudgetImportParser parser = const CategoryBudgetImportParser(),
  })  : _categories = categoryRepository,
        _allocations = allocationRepository,
        _budgets = budgetRepository,
        _transactions = transactionRepository,
        _parser = parser;

  final CategoryRepository _categories;
  final CategoryBudgetAllocationRepository _allocations;
  final BudgetRepository _budgets;
  final TransactionRepository _transactions;
  final CategoryBudgetImportParser _parser;

  Future<CategoryBudgetImportResult> import({
    required String budgetText,
    required String spendText,
    DateTime? now,
  }) async {
    final budgetRows = _parser.parseBudgetTable(budgetText);
    final spendRows = _parser.parseTodaySpend(spendText);
    if (budgetRows.isEmpty && spendRows.isEmpty) {
      throw const FormatException('가져올 예산 또는 소비 내역이 없습니다.');
    }

    final timestamp = now ?? DateTime.now();
    final yearMonth =
        '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}';
    final categoryCache = <String, Category>{};

    Future<Category> resolve(String name) async {
      final canonicalName = _canonicalName(name);
      final cached = categoryCache[canonicalName];
      if (cached != null) {
        return cached;
      }
      var category = await _categories.getByName(canonicalName);
      if (category == null) {
        final existing = await _categories.getByName(name.trim());
        category = existing;
      }
      if (category == null) {
        final categories = await _categories.watchAllCategories().first;
        await _categories.createCategory(
          Category(
            id: 0,
            name: canonicalName,
            icon: 'circle',
            colorToken: null,
            sortOrder: categories.length,
            isActive: true,
            isDefault: false,
            createdAt: timestamp,
            updatedAt: timestamp,
          ),
        );
        category = await _categories.getByName(canonicalName);
      }
      if (category == null) {
        throw FormatException('카테고리를 만들 수 없습니다: $name');
      }
      categoryCache[canonicalName] = category;
      return category;
    }

    final allocations = <CategoryBudgetAllocation>[];
    for (final row in budgetRows) {
      final category = await resolve(row.categoryName);
      allocations.add(
        CategoryBudgetAllocation(
          id: 0,
          categoryId: category.id,
          yearMonth: yearMonth,
          budgetAmount: row.amount,
          createdAt: timestamp,
          updatedAt: timestamp,
        ),
      );
    }
    if (budgetRows.isNotEmpty) {
      await _allocations.replaceForMonth(yearMonth, allocations);
      final totalBudget = budgetRows.fold<int>(
        0,
        (sum, row) => sum + row.amount,
      );
      await _budgets.upsertBudget(
        Budget(
          id: 0,
          monthlyBudget: totalBudget,
          currencyCode: 'KRW',
          effectiveMonth: yearMonth,
          createdAt: timestamp,
          updatedAt: timestamp,
        ),
      );
    }

    for (final row in spendRows) {
      final category = await resolve(row.categoryName);
      await _transactions.createTransaction(
        SpendingTransaction(
          id: 0,
          amount: row.amount,
          type: TransactionType.expense,
          budgetType: BudgetType.monthly,
          specialCategory: null,
          categoryId: category.id,
          occurredAt: timestamp,
          memo: row.memo,
          source: 'imported',
          linkedUpcomingExpenseId: null,
          createdAt: timestamp,
          updatedAt: timestamp,
          deletedAt: null,
        ),
      );
    }

    return CategoryBudgetImportResult(
      budgetCount: budgetRows.length,
      transactionCount: spendRows.length,
      totalBudget: budgetRows.fold<int>(0, (sum, row) => sum + row.amount),
    );
  }

  String _canonicalName(String input) {
    final name = input.trim().toUpperCase().replaceAll(RegExp(r'\s+'), ' ');
    const aliases = {
      '데이트': 'DATE',
      '데이트 식사·카페·술': 'DATE',
      '혼자 먹는 외식, 카페, 간식, 배달': 'EAT',
      '쇼핑': 'SHOP',
      '생활·미용·의료': 'LIFE',
      '편의점·잡화': 'ETC',
      '자유 버퍼': 'ETC',
    };
    return aliases[name] ?? name;
  }
}
