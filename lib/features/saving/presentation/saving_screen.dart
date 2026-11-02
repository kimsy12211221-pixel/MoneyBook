import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/types/enums.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../domain/models/transaction.dart';
import '../../../domain/providers/budget_provider.dart';
import '../../../domain/providers/category_provider.dart';
import '../../../domain/providers/current_date_provider.dart';
import '../../../domain/providers/saving_provider.dart';
import '../../../domain/providers/transaction_provider.dart';
import '../../../shared/widgets/app_divider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/meta_label.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/section_header.dart';

class SavingScreen extends ConsumerStatefulWidget {
  const SavingScreen({super.key});

  @override
  ConsumerState<SavingScreen> createState() => _SavingScreenState();
}

class _SavingScreenState extends ConsumerState<SavingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(savingPlanControllerProvider).ensurePlan(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final colors = Theme.of(context).extension<AppColorTokens>()!;
    final now = ref.watch(currentDateProvider).valueOrNull ?? DateTime.now();
    final plan = ref.watch(currentSavingPlanProvider).valueOrNull;
    final values = _SavingValues.fromPlan(plan);
    final monthlyBudget = ref.watch(currentMonthBudgetAmountProvider) ??
        values.livingBudgetTarget;
    final transactions =
        ref.watch(currentMonthMonthlyTransactionsProvider).valueOrNull ??
            const <SpendingTransaction>[];
    final spent = transactions.fold<int>(0, (sum, item) => sum + item.amount);
    final remaining = monthlyBudget - spent;
    final creditCards = transactions
        .where((item) => item.paymentMethod == PaymentMethod.creditCard)
        .toList(growable: false);
    final cardUsed = creditCards.fold<int>(0, (sum, item) => sum + item.amount);
    final cardRemaining = 300000 - cardUsed;
    final wealth = (values.etfDone ? values.etfTarget : 0) +
        (values.housingDone ? values.housingTarget : 0) +
        (values.sweepAmount ?? 0);
    final reserve = values.annualSpecialDone ? values.annualSpecialTarget : 0;
    final complete = values.isPaydayComplete;
    final categoryMap = ref.watch(categoryNameMapProvider);

    return AppScaffold(
      child: ListView(
        children: [
          SizedBox(height: spacing.lg),
          const SectionHeader('SAVING'),
          SizedBox(height: spacing.sm),
          MetaLabel('${_monthLabel(now)} SAVING'),
          SizedBox(height: spacing.lg),
          Text(
            CurrencyFormatter.formatKrw(wealth),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const MetaLabel('WEALTH · ETF + HOUSING + SWEEP'),
          SizedBox(height: spacing.md),
          Text(
            CurrencyFormatter.formatKrw(reserve),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const MetaLabel('RESERVE · ANNUAL SPECIAL'),
          SizedBox(height: spacing.lg),
          if (complete)
            Text(
              'PAYDAY SETUP COMPLETE ✓',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colors.accent,
                  ),
            )
          else
            const MetaLabel('PAYDAY SETUP IN PROGRESS'),
          SizedBox(height: spacing.xl),
          const AppDivider(),
          SizedBox(height: spacing.md),
          const SectionHeader('MONTHLY SAVING PLAN'),
          SizedBox(height: spacing.md),
          _SavingStepRow(
            label: values.etfLabel,
            amount: values.etfTarget,
            done: values.etfDone,
            onDone: () => _markDone(SavingPlanStep.etf, now),
          ),
          const AppDivider(),
          _SavingStepRow(
            label: values.annualSpecialLabel,
            amount: values.annualSpecialTarget,
            done: values.annualSpecialDone,
            onDone: () => _markDone(SavingPlanStep.annualSpecial, now),
          ),
          const AppDivider(),
          _SavingStepRow(
            label: values.livingLabel,
            amount: values.livingBudgetTarget,
            done: values.livingDone,
            onDone: () => _markDone(SavingPlanStep.living, now),
          ),
          const AppDivider(),
          _SavingStepRow(
            label: values.housingLabel,
            amount: values.housingTarget,
            done: values.housingDone,
            onDone: () => _markDone(SavingPlanStep.housing, now),
          ),
          const AppDivider(),
          _SavingStepRow(
            label: values.fixedCostLabel,
            amount: values.fixedCostTarget,
            done: values.fixedCostDone,
            onDone: () => _markDone(SavingPlanStep.fixedCost, now),
          ),
          SizedBox(height: spacing.xl),
          const AppDivider(),
          SizedBox(height: spacing.md),
          const SectionHeader('SPENDING ACCOUNT'),
          SizedBox(height: spacing.md),
          _LedgerLine(label: 'BUDGET', amount: monthlyBudget),
          _LedgerLine(label: 'SPENT', amount: spent),
          _LedgerLine(
            label: 'REMAINING',
            amount: remaining,
            color: remaining < 0 ? colors.danger : colors.accent,
          ),
          SizedBox(height: spacing.xl),
          const AppDivider(),
          SizedBox(height: spacing.md),
          const SectionHeader('CREDIT CARD'),
          SizedBox(height: spacing.md),
          _LedgerLine(label: 'TARGET', amount: 300000),
          _LedgerLine(label: 'USED', amount: cardUsed),
          _LedgerLine(
            label: 'REMAINING',
            amount: cardRemaining,
            color: cardRemaining <= 0 ? colors.danger : colors.accent,
          ),
          if (cardRemaining <= 0) ...[
            SizedBox(height: spacing.md),
            Text(
              'CARD TARGET COMPLETE — STOP USING',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colors.danger,
                  ),
            ),
          ],
          if (creditCards.isNotEmpty) ...[
            SizedBox(height: spacing.md),
            for (final item in creditCards) ...[
              const AppDivider(),
              _CreditCardRow(
                item: item,
                title: item.memo ??
                    categoryMap[item.categoryId]?.name ??
                    'CARD PAYMENT',
                onPrepay: item.prepaidAt == null
                    ? () =>
                        ref.read(savingPlanControllerProvider).markPrepaid(item)
                    : null,
              ),
            ],
          ],
          SizedBox(height: spacing.xl),
          const AppDivider(),
          SizedBox(height: spacing.md),
          const SectionHeader('MONTH END SWEEP'),
          SizedBox(height: spacing.md),
          _LedgerLine(label: 'LIVING BUDGET', amount: monthlyBudget),
          _LedgerLine(label: 'ACTUAL SPENT', amount: spent),
          _LedgerLine(
            label: values.sweepAmount == null
                ? 'AVAILABLE TO SWEEP'
                : 'OCTOBER SWEEP',
            amount: values.sweepAmount ?? remaining.clamp(0, monthlyBudget),
            color: colors.accent,
          ),
          SizedBox(height: spacing.md),
          PrimaryButton(
            label: values.sweepAmount == null
                ? '→ 주택저축으로 보내기'
                : 'SWEPT ${CurrencyFormatter.compactKrw(values.sweepAmount!)}',
            onPressed: values.sweepAmount != null || remaining <= 0
                ? null
                : () => ref
                    .read(savingPlanControllerProvider)
                    .sweep(now, remaining),
          ),
          SizedBox(height: spacing.xxl),
        ],
      ),
    );
  }

  Future<void> _markDone(SavingPlanStep step, DateTime now) async {
    await ref.read(savingPlanControllerProvider).markStepDone(now, step);
  }

  String _monthLabel(DateTime date) {
    const months = [
      'JANUARY',
      'FEBRUARY',
      'MARCH',
      'APRIL',
      'MAY',
      'JUNE',
      'JULY',
      'AUGUST',
      'SEPTEMBER',
      'OCTOBER',
      'NOVEMBER',
      'DECEMBER',
    ];
    return months[date.month - 1];
  }
}

class _SavingValues {
  const _SavingValues({
    required this.etfTarget,
    required this.etfLabel,
    required this.annualSpecialTarget,
    required this.annualSpecialLabel,
    required this.livingBudgetTarget,
    required this.livingLabel,
    required this.housingTarget,
    required this.housingLabel,
    required this.fixedCostTarget,
    required this.fixedCostLabel,
    required this.etfDone,
    required this.annualSpecialDone,
    required this.livingDone,
    required this.housingDone,
    required this.fixedCostDone,
    required this.sweepAmount,
  });

  factory _SavingValues.fromPlan(dynamic plan) => _SavingValues(
        etfTarget: plan?.etfTarget ?? 1000000,
        etfLabel: plan?.etfLabel ?? '신한투자 / ETF투자',
        annualSpecialTarget: plan?.annualSpecialTarget ?? 330000,
        annualSpecialLabel:
            plan?.annualSpecialLabel ?? '토스나눠모으기 / ANNUAL SPECIAL',
        livingBudgetTarget: plan?.livingBudgetTarget ?? 1200000,
        livingLabel: plan?.livingLabel ?? '케이뱅크 / 생활비이체',
        housingTarget: plan?.housingTarget ?? 114750,
        housingLabel: plan?.housingLabel ?? '토스나눠모으기 / 비상금',
        fixedCostTarget: plan?.fixedCostTarget ?? 1355250,
        fixedCostLabel: plan?.fixedCostLabel ?? '토스통장 / 고정비확보',
        etfDone: plan?.etfDoneAt != null,
        annualSpecialDone: plan?.annualSpecialDoneAt != null,
        livingDone: plan?.livingDoneAt != null,
        housingDone: plan?.housingDoneAt != null,
        fixedCostDone: plan?.fixedCostDoneAt != null,
        sweepAmount: plan?.sweepAmount,
      );

  final int etfTarget;
  final String etfLabel;
  final int annualSpecialTarget;
  final String annualSpecialLabel;
  final int livingBudgetTarget;
  final String livingLabel;
  final int housingTarget;
  final String housingLabel;
  final int fixedCostTarget;
  final String fixedCostLabel;
  final bool etfDone;
  final bool annualSpecialDone;
  final bool livingDone;
  final bool housingDone;
  final bool fixedCostDone;
  final int? sweepAmount;

  bool get isPaydayComplete =>
      etfDone &&
      annualSpecialDone &&
      livingDone &&
      housingDone &&
      fixedCostDone;
}

class _SavingStepRow extends StatelessWidget {
  const _SavingStepRow({
    required this.label,
    required this.amount,
    required this.done,
    required this.onDone,
  });

  final String label;
  final int amount;
  final bool done;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorTokens>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(done ? Icons.check_circle : Icons.circle_outlined,
              color: done ? colors.accent : colors.textMuted),
          const SizedBox(width: 12),
          Expanded(
              child:
                  Text(label, style: Theme.of(context).textTheme.titleMedium)),
          Text(CurrencyFormatter.formatKrw(amount)),
          const SizedBox(width: 12),
          TextButton(
            onPressed: done ? null : onDone,
            child: Text(done ? 'DONE' : 'MARK DONE'),
          ),
        ],
      ),
    );
  }
}

class _LedgerLine extends StatelessWidget {
  const _LedgerLine({required this.label, required this.amount, this.color});

  final String label;
  final int amount;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(child: MetaLabel(label)),
          Text(
            CurrencyFormatter.formatKrw(amount),
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _CreditCardRow extends StatelessWidget {
  const _CreditCardRow({
    required this.item,
    required this.title,
    required this.onPrepay,
  });

  final SpendingTransaction item;
  final String title;
  final VoidCallback? onPrepay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                MetaLabel(item.prepaidAt == null ? 'UNPAID' : 'PREPAID'),
              ],
            ),
          ),
          Text(CurrencyFormatter.compactKrw(item.amount)),
          const SizedBox(width: 12),
          TextButton(
            onPressed: onPrepay,
            child: Text(item.prepaidAt == null ? '선결제 완료' : 'DONE'),
          ),
        ],
      ),
    );
  }
}
