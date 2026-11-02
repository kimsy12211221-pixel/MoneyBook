import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_range_utils.dart';
import '../../../domain/models/budget.dart';
import '../../../domain/models/category.dart';
import '../../../domain/models/category_budget_allocation.dart';
import '../../../domain/providers/category_budget_provider.dart';
import '../../../domain/providers/category_provider.dart';
import '../../../domain/providers/repositories_provider.dart';
import '../../../shared/widgets/app_divider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/section_header.dart';
import 'category_budget_import_screen.dart';

class CategoryManagementScreen extends ConsumerStatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  ConsumerState<CategoryManagementScreen> createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState
    extends ConsumerState<CategoryManagementScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories =
        ref.watch(allCategoriesProvider).valueOrNull ?? const <Category>[];
    final allocations =
        ref.watch(currentMonthCategoryBudgetsProvider).valueOrNull ??
            const <CategoryBudgetAllocation>[];
    final budgetMap = {
      for (final item in allocations) item.categoryId: item,
    };

    return AppScaffold(
      child: ListView(
        children: [
          const SizedBox(height: 24),
          const SectionHeader('CATEGORIES'),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const CategoryBudgetImportScreen(),
                ),
              ),
              icon: const Icon(Icons.table_chart_outlined),
              label: const Text('PASTE BUDGET TABLE'),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(labelText: 'ADD CATEGORY'),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: _addCategory,
                child: const Text('ADD'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          for (final category in categories) ...[
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(category.name),
              subtitle: Text(
                '${category.description?.trim().isNotEmpty == true ? category.description : '설명 없음'}\n'
                '${category.isDefault ? 'DEFAULT' : 'CUSTOM'} · '
                '${CurrencyFormatter.formatKrw(budgetMap[category.id]?.budgetAmount ?? 0)} / MONTH',
              ),
              value: category.isActive,
              onChanged: (value) => _toggleCategory(category, value),
              secondary: PopupMenuButton<String>(
                onSelected: (value) => _handleCategoryMenuSelection(
                  category,
                  budgetMap[category.id],
                  value,
                ),
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'name', child: Text('EDIT NAME')),
                  PopupMenuItem(
                    value: 'description',
                    child: Text('EDIT DESCRIPTION'),
                  ),
                  PopupMenuItem(value: 'budget', child: Text('SET BUDGET')),
                ],
              ),
            ),
            const AppDivider(),
          ],
        ],
      ),
    );
  }

  Future<void> _addCategory() async {
    final name = _controller.text.trim().toUpperCase();
    if (name.isEmpty) {
      return;
    }
    final categories =
        ref.read(allCategoriesProvider).valueOrNull ?? const <Category>[];
    final now = DateTime.now();
    await ref.read(categoryRepositoryProvider).createCategory(
          Category(
            id: 0,
            name: name,
            icon: 'circle',
            description: null,
            colorToken: null,
            sortOrder: categories.length,
            isActive: true,
            isDefault: false,
            createdAt: now,
            updatedAt: now,
          ),
        );
    _controller.clear();
  }

  Future<void> _toggleCategory(Category category, bool isActive) async {
    await ref.read(categoryRepositoryProvider).updateCategory(
          Category(
            id: category.id,
            name: category.name,
            icon: category.icon,
            description: category.description,
            colorToken: category.colorToken,
            sortOrder: category.sortOrder,
            isActive: isActive,
            isDefault: category.isDefault,
            createdAt: category.createdAt,
            updatedAt: DateTime.now(),
          ),
        );
  }

  Future<void> _handleCategoryMenuSelection(
    Category category,
    CategoryBudgetAllocation? allocation,
    String value,
  ) async {
    // Let the popup route finish closing before opening a dialog route.
    await Future<void>.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    switch (value) {
      case 'name':
        return _editCategoryName(category);
      case 'description':
        return _editCategoryDescription(category);
      case 'budget':
        return _editCategoryBudget(category, allocation);
    }
  }

  Future<void> _editCategoryName(Category category) async {
    final value = await showDialog<String>(
      context: context,
      builder: (_) => _CategoryTextDialog(
        title: 'EDIT CATEGORY',
        initialValue: category.name,
      ),
    );
    final name = value?.trim().toUpperCase();
    if (name == null || name.isEmpty || name == category.name) {
      return;
    }
    await ref.read(categoryRepositoryProvider).updateCategory(
          Category(
            id: category.id,
            name: name,
            icon: category.icon,
            description: category.description,
            colorToken: category.colorToken,
            sortOrder: category.sortOrder,
            isActive: category.isActive,
            isDefault: category.isDefault,
            createdAt: category.createdAt,
            updatedAt: DateTime.now(),
          ),
        );
  }

  Future<void> _editCategoryDescription(Category category) async {
    final value = await showDialog<String>(
      context: context,
      builder: (_) => _CategoryTextDialog(
        title: '${category.name} DESCRIPTION',
        initialValue: category.description ?? '',
        maxLines: 3,
      ),
    );
    if (value == null) {
      return;
    }

    await ref.read(categoryRepositoryProvider).updateCategory(
          Category(
            id: category.id,
            name: category.name,
            icon: category.icon,
            description: value.trim(),
            colorToken: category.colorToken,
            sortOrder: category.sortOrder,
            isActive: category.isActive,
            isDefault: category.isDefault,
            createdAt: category.createdAt,
            updatedAt: DateTime.now(),
          ),
        );
  }

  Future<void> _editCategoryBudget(
    Category category,
    CategoryBudgetAllocation? existing,
  ) async {
    final value = await showDialog<int>(
      context: context,
      builder: (_) => _CategoryBudgetDialog(
        categoryName: category.name,
        initialAmount: existing?.budgetAmount,
      ),
    );
    if (value == null || value < 0) {
      return;
    }
    final now = DateTime.now();
    await ref.read(categoryBudgetAllocationRepositoryProvider).upsert(
          CategoryBudgetAllocation(
            id: existing?.id ?? 0,
            categoryId: category.id,
            yearMonth: DateRangeUtils.yearMonthKey(now),
            budgetAmount: value,
            createdAt: existing?.createdAt ?? now,
            updatedAt: now,
          ),
        );
    final allocations = await ref
        .read(categoryBudgetAllocationRepositoryProvider)
        .watchForMonth(DateRangeUtils.yearMonthKey(now))
        .first;
    final total =
        allocations.fold<int>(0, (sum, item) => sum + item.budgetAmount);
    await ref.read(budgetRepositoryProvider).upsertBudget(
          Budget(
            id: 0,
            monthlyBudget: total,
            currencyCode: 'KRW',
            effectiveMonth: DateRangeUtils.yearMonthKey(now),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }
}

class _CategoryTextDialog extends StatefulWidget {
  const _CategoryTextDialog({
    required this.title,
    required this.initialValue,
    this.maxLines = 1,
  });

  final String title;
  final String initialValue;
  final int maxLines;

  @override
  State<_CategoryTextDialog> createState() => _CategoryTextDialogState();
}

class _CategoryTextDialogState extends State<_CategoryTextDialog> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialValue);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLines: widget.maxLines,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: const Text('SAVE'),
        ),
      ],
    );
  }
}

class _CategoryBudgetDialog extends StatefulWidget {
  const _CategoryBudgetDialog({
    required this.categoryName,
    required this.initialAmount,
  });

  final String categoryName;
  final int? initialAmount;

  @override
  State<_CategoryBudgetDialog> createState() => _CategoryBudgetDialogState();
}

class _CategoryBudgetDialogState extends State<_CategoryBudgetDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialAmount?.toString() ?? '',
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.categoryName} BUDGET'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(prefixText: '₩ '),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(
            int.tryParse(_controller.text.replaceAll(',', '')),
          ),
          child: const Text('SAVE'),
        ),
      ],
    );
  }
}
