import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../domain/providers/current_date_provider.dart';
import '../../../domain/providers/saving_provider.dart';
import '../../../shared/widgets/app_divider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/meta_label.dart';
import '../../../shared/widgets/section_header.dart';

class SavingBudgetScreen extends ConsumerWidget {
  const SavingBudgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final now = ref.watch(currentDateProvider).valueOrNull ?? DateTime.now();
    final plan = ref.watch(currentSavingPlanProvider).valueOrNull;
    final values = _SavingBudgetValues.fromPlan(plan);
    final allocationTotal = values.etf +
        values.annualSpecial +
        values.living +
        values.housing +
        values.fixedCost;

    return AppScaffold(
      child: ListView(
        children: [
          SizedBox(height: spacing.lg),
          const SectionHeader('SAVING BUDGET'),
          SizedBox(height: spacing.sm),
          const MetaLabel('TAP A NAME OR AMOUNT TO EDIT · CURRENT MONTH'),
          SizedBox(height: spacing.xl),
          _SavingBudgetItem(
            label: 'MONTHLY SALARY',
            amount: values.salary,
            onLabelTap: null,
            onTap: () => _edit(
                context, ref, now, SavingPlanTarget.salary, values.salary),
          ),
          SizedBox(height: spacing.md),
          const AppDivider(),
          SizedBox(height: spacing.md),
          _SavingBudgetItem(
            label: values.etfLabel,
            amount: values.etf,
            onLabelTap: () => _editLabel(
              context,
              ref,
              now,
              SavingPlanStep.etf,
              values.etfLabel,
            ),
            onTap: () =>
                _edit(context, ref, now, SavingPlanTarget.etf, values.etf),
          ),
          SizedBox(height: spacing.md),
          const AppDivider(),
          SizedBox(height: spacing.md),
          _SavingBudgetItem(
            label: values.annualSpecialLabel,
            amount: values.annualSpecial,
            onLabelTap: () => _editLabel(
              context,
              ref,
              now,
              SavingPlanStep.annualSpecial,
              values.annualSpecialLabel,
            ),
            onTap: () => _edit(context, ref, now,
                SavingPlanTarget.annualSpecial, values.annualSpecial),
          ),
          SizedBox(height: spacing.md),
          const AppDivider(),
          SizedBox(height: spacing.md),
          _SavingBudgetItem(
            label: values.livingLabel,
            amount: values.living,
            onLabelTap: () => _editLabel(
              context,
              ref,
              now,
              SavingPlanStep.living,
              values.livingLabel,
            ),
            onTap: () => _edit(
                context, ref, now, SavingPlanTarget.living, values.living),
          ),
          SizedBox(height: spacing.md),
          const AppDivider(),
          SizedBox(height: spacing.md),
          _SavingBudgetItem(
            label: values.housingLabel,
            amount: values.housing,
            onLabelTap: () => _editLabel(
              context,
              ref,
              now,
              SavingPlanStep.housing,
              values.housingLabel,
            ),
            onTap: () => _edit(
                context, ref, now, SavingPlanTarget.housing, values.housing),
          ),
          SizedBox(height: spacing.md),
          const AppDivider(),
          SizedBox(height: spacing.md),
          _SavingBudgetItem(
            label: values.fixedCostLabel,
            amount: values.fixedCost,
            onLabelTap: () => _editLabel(
              context,
              ref,
              now,
              SavingPlanStep.fixedCost,
              values.fixedCostLabel,
            ),
            onTap: () => _edit(context, ref, now, SavingPlanTarget.fixedCost,
                values.fixedCost),
          ),
          SizedBox(height: spacing.lg),
          const AppDivider(),
          SizedBox(height: spacing.md),
          _SavingBudgetItem(
            label: 'ALLOCATED TOTAL',
            amount: allocationTotal,
            onLabelTap: null,
            onTap: null,
          ),
          SizedBox(height: spacing.sm),
          MetaLabel(
            allocationTotal == values.salary
                ? 'PAYDAY PLAN BALANCED'
                : 'UNALLOCATED ${CurrencyFormatter.formatKrw(values.salary - allocationTotal)}',
          ),
          SizedBox(height: spacing.xxl),
        ],
      ),
    );
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref,
    DateTime now,
    SavingPlanTarget target,
    int currentValue,
  ) async {
    final value = await showDialog<int>(
      context: context,
      builder: (_) => _SavingAmountDialog(
        title: _targetLabel(target),
        initialAmount: currentValue,
      ),
    );
    if (value == null) return;
    await ref
        .read(savingPlanControllerProvider)
        .updateTarget(now, target, value);
  }

  Future<void> _editLabel(
    BuildContext context,
    WidgetRef ref,
    DateTime now,
    SavingPlanStep step,
    String currentLabel,
  ) async {
    final label = await showDialog<String>(
      context: context,
      builder: (_) => _SavingLabelDialog(initialLabel: currentLabel),
    );
    if (label == null) return;
    await ref.read(savingPlanControllerProvider).updateLabel(now, step, label);
  }

  String _targetLabel(SavingPlanTarget target) => switch (target) {
        SavingPlanTarget.salary => 'MONTHLY SALARY',
        SavingPlanTarget.etf => 'ETF',
        SavingPlanTarget.annualSpecial => 'ANNUAL SPECIAL RESERVE',
        SavingPlanTarget.living => 'LIVING ACCOUNT',
        SavingPlanTarget.housing => 'HOUSING SAVINGS',
        SavingPlanTarget.fixedCost => 'FIXED COST RESERVE',
      };
}

class _SavingBudgetValues {
  const _SavingBudgetValues({
    required this.salary,
    required this.etf,
    required this.etfLabel,
    required this.annualSpecial,
    required this.annualSpecialLabel,
    required this.living,
    required this.livingLabel,
    required this.housing,
    required this.housingLabel,
    required this.fixedCost,
    required this.fixedCostLabel,
  });

  factory _SavingBudgetValues.fromPlan(dynamic plan) => _SavingBudgetValues(
        salary: plan?.salaryAmount ?? 4000000,
        etf: plan?.etfTarget ?? 1000000,
        etfLabel: plan?.etfLabel ?? '신한투자 / ETF투자',
        annualSpecial: plan?.annualSpecialTarget ?? 330000,
        annualSpecialLabel:
            plan?.annualSpecialLabel ?? '토스나눠모으기 / ANNUAL SPECIAL',
        living: plan?.livingBudgetTarget ?? 1200000,
        livingLabel: plan?.livingLabel ?? '케이뱅크 / 생활비이체',
        housing: plan?.housingTarget ?? 114750,
        housingLabel: plan?.housingLabel ?? '토스나눠모으기 / 비상금',
        fixedCost: plan?.fixedCostTarget ?? 1355250,
        fixedCostLabel: plan?.fixedCostLabel ?? '토스통장 / 고정비확보',
      );

  final int salary;
  final int etf;
  final String etfLabel;
  final int annualSpecial;
  final String annualSpecialLabel;
  final int living;
  final String livingLabel;
  final int housing;
  final String housingLabel;
  final int fixedCost;
  final String fixedCostLabel;
}

class _SavingBudgetItem extends StatelessWidget {
  const _SavingBudgetItem({
    required this.label,
    required this.amount,
    required this.onLabelTap,
    required this.onTap,
  });

  final String label;
  final int amount;
  final VoidCallback? onLabelTap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onLabelTap,
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (onLabelTap != null) ...[
                  const SizedBox(width: 6),
                  const Icon(Icons.edit_outlined, size: 16),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        InkWell(
          onTap: onTap,
          child: Text(
            CurrencyFormatter.formatKrw(amount),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}

class _SavingLabelDialog extends StatefulWidget {
  const _SavingLabelDialog({required this.initialLabel});

  final String initialLabel;

  @override
  State<_SavingLabelDialog> createState() => _SavingLabelDialogState();
}

class _SavingLabelDialogState extends State<_SavingLabelDialog> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialLabel);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('SAVING PLAN NAME'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLength: 24,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(hintText: '예: ETF, 여행 적금'),
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

class _SavingAmountDialog extends StatefulWidget {
  const _SavingAmountDialog({required this.title, required this.initialAmount});

  final String title;
  final int initialAmount;

  @override
  State<_SavingAmountDialog> createState() => _SavingAmountDialogState();
}

class _SavingAmountDialogState extends State<_SavingAmountDialog> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialAmount.toString());

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
