import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_range_utils.dart';
import '../../../domain/models/annual_special_budget.dart';
import '../../../domain/models/budget.dart';
import '../../../domain/providers/annual_special_provider.dart';
import '../../../domain/providers/budget_provider.dart';
import '../../../domain/providers/repositories_provider.dart';
import '../../../shared/widgets/app_divider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/meta_label.dart';
import '../../../shared/widgets/section_header.dart';
import 'category_management_screen.dart';
import '../../saving/presentation/saving_budget_screen.dart';

class BudgetManagementScreen extends ConsumerWidget {
  const BudgetManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final monthlyBudget = ref.watch(currentMonthBudgetAmountProvider);
    final annualBudget =
        ref.watch(currentYearAnnualSpecialBudgetProvider).valueOrNull;

    return AppScaffold(
      child: ListView(
        children: [
          SizedBox(height: spacing.lg),
          const SectionHeader('BUDGET'),
          SizedBox(height: spacing.xl),
          _BudgetItem(
            title: 'ANNUAL SPECIAL BUDGET',
            meta: annualBudget == null
                ? 'NOT SET'
                : CurrencyFormatter.formatKrw(annualBudget.budgetAmount),
            onTap: () => _editAnnualBudget(context, ref, annualBudget),
          ),
          SizedBox(height: spacing.md),
          const AppDivider(),
          SizedBox(height: spacing.md),
          _BudgetItem(
            title: 'MONTHLY BUDGET',
            meta: monthlyBudget == null
                ? 'NOT SET'
                : CurrencyFormatter.formatKrw(monthlyBudget),
            onTap: () => _editMonthlyBudget(context, ref, monthlyBudget),
          ),
          SizedBox(height: spacing.md),
          const AppDivider(),
          SizedBox(height: spacing.md),
          Padding(
            padding: EdgeInsets.only(left: spacing.md),
            child: _BudgetItem(
              title: 'CATEGORIES',
              meta: 'MONTHLY',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const CategoryManagementScreen(),
                ),
              ),
            ),
          ),
          SizedBox(height: spacing.md),
          const AppDivider(),
          SizedBox(height: spacing.md),
          _BudgetItem(
            title: 'SAVING BUDGET',
            meta: 'MANAGE',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const SavingBudgetScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editMonthlyBudget(
    BuildContext context,
    WidgetRef ref,
    int? currentBudget,
  ) async {
    final value = await _promptBudget(
      context,
      title: 'MONTHLY BUDGET',
      initialValue: currentBudget?.toString() ?? '',
    );
    if (value == null || value <= 0) return;

    final now = DateTime.now();
    await ref.read(budgetRepositoryProvider).upsertBudget(
          Budget(
            id: 0,
            monthlyBudget: value,
            currencyCode: 'KRW',
            effectiveMonth: DateRangeUtils.yearMonthKey(now),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  Future<void> _editAnnualBudget(
    BuildContext context,
    WidgetRef ref,
    AnnualSpecialBudget? currentBudget,
  ) async {
    final value = await _promptBudget(
      context,
      title: 'ANNUAL SPECIAL BUDGET',
      initialValue: currentBudget?.budgetAmount.toString() ?? '4000000',
    );
    if (value == null || value <= 0) return;

    final now = DateTime.now();
    await ref.read(annualSpecialBudgetRepositoryProvider).upsert(
          AnnualSpecialBudget(
            id: 0,
            year: now.year,
            budgetAmount: value,
            currencyCode: 'KRW',
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  Future<int?> _promptBudget(
    BuildContext context, {
    required String title,
    required String initialValue,
  }) async {
    return showDialog<int>(
      context: context,
      builder: (_) => _BudgetValueDialog(
        title: title,
        initialValue: initialValue,
      ),
    );
  }
}

class _BudgetValueDialog extends StatefulWidget {
  const _BudgetValueDialog({
    required this.title,
    required this.initialValue,
  });

  final String title;
  final String initialValue;

  @override
  State<_BudgetValueDialog> createState() => _BudgetValueDialogState();
}

class _BudgetValueDialogState extends State<_BudgetValueDialog> {
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

class _BudgetItem extends StatelessWidget {
  const _BudgetItem({
    required this.title,
    required this.meta,
    required this.onTap,
  });

  final String title;
  final String meta;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
          ),
          MetaLabel(meta),
        ],
      ),
    );
  }
}
