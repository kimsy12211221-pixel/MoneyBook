import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/types/enums.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_range_utils.dart';
import '../../../domain/models/monthly_summary.dart';
import '../../../domain/providers/budget_provider.dart';
import '../../../domain/providers/annual_special_provider.dart';
import '../../../domain/providers/monthly_summary_provider.dart';
import '../../../domain/providers/safe_to_spend_provider.dart';
import '../../../shared/widgets/app_divider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/meta_label.dart';
import '../../../shared/widgets/section_header.dart';
import 'category_spending_screen.dart';

class MonthlySummaryScreen extends ConsumerWidget {
  const MonthlySummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final colors = Theme.of(context).extension<AppColorTokens>()!;
    final summary = ref.watch(currentMonthSummaryProvider);
    final budget = ref.watch(currentMonthBudgetAmountProvider);
    final credit = ref.watch(safeToSpendSnapshotProvider).valueOrNull;
    final annualSnapshot = ref.watch(annualSpecialSnapshotProvider).valueOrNull;

    if (summary == null) {
      return const AppScaffold(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final budgetProgress = budget == null || budget == 0
        ? 0.0
        : (summary.totalSpent / budget).clamp(0.0, 1.0);
    final budgetUsagePercent = budget == null || budget == 0
        ? 0
        : ((summary.totalSpent / budget) * 100).round();
    final budgetRemaining = budget == null ? 0 : budget - summary.totalSpent;
    final topCategory = summary.categoryBreakdown.isEmpty
        ? null
        : summary.categoryBreakdown.first;

    return AppScaffold(
      child: ListView(
        children: [
          SizedBox(height: spacing.lg),
          const SectionHeader('EXPENSE SUMMARY'),
          SizedBox(height: spacing.sm),
          MetaLabel('${summary.yearMonth} · MONTHLY REVIEW'),
          SizedBox(height: spacing.lg),
          Text(
            CurrencyFormatter.formatKrw(summary.totalSpent),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: spacing.xs),
          const MetaLabel('SPENT THIS MONTH'),
          SizedBox(height: spacing.sm),
          Text(
            '${summary.totalTransactions} PAYMENTS · ${summary.spendingDays} SPENDING DAYS',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: spacing.lg),
          if (budget != null) ...[
            const AppDivider(),
            SizedBox(height: spacing.md),
            Row(
              children: [
                const Expanded(child: MetaLabel('BUDGET STATUS')),
                MetaLabel('$budgetUsagePercent% USED'),
              ],
            ),
            SizedBox(height: spacing.sm),
            Text(
              budgetRemaining < 0
                  ? 'OVER ${CurrencyFormatter.formatKrw(budgetRemaining.abs())}'
                  : 'LEFT ${CurrencyFormatter.formatKrw(budgetRemaining)}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: budgetRemaining < 0
                        ? colors.danger
                        : colors.textPrimary,
                  ),
            ),
            SizedBox(height: spacing.xs),
            Text(
              budgetRemaining < 0
                  ? 'PAUSE OPTIONAL SPENDING UNTIL CREDIT RECOVERS.'
                  : 'KEEP THE REMAINING BUDGET INTENTIONAL.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: spacing.md),
            LinearProgressIndicator(
              value: budgetProgress,
              minHeight: 6,
              color: budgetRemaining < 0 ? colors.danger : colors.accent,
              backgroundColor: colors.divider,
            ),
            SizedBox(height: spacing.sm),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${CurrencyFormatter.formatKrw(summary.totalSpent)} / ${CurrencyFormatter.formatKrw(budget)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                MetaLabel(
                  'CREDIT ${CurrencyFormatter.compactKrw(credit?.creditBalance ?? 0)}',
                  color: credit != null && credit.creditBalance < 0
                      ? colors.danger
                      : colors.accent,
                ),
              ],
            ),
            SizedBox(height: spacing.xl),
          ],
          const AppDivider(),
          SizedBox(height: spacing.md),
          const SectionHeader('SPENDING PATTERN'),
          SizedBox(height: spacing.md),
          Row(
            children: [
              Expanded(
                child: _StatPair(
                  label: 'DAILY PACE · ${summary.elapsedDays} DAYS',
                  value: CurrencyFormatter.compactKrw(
                    summary.averageCalendarDailySpend,
                  ),
                ),
              ),
              Expanded(
                child: _StatPair(
                  label: 'AVG / SPENDING DAY',
                  value: CurrencyFormatter.compactKrw(
                    summary.averageDailySpend,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spacing.lg),
          _StatPair(
            label: 'AVG / PAYMENT',
            value: CurrencyFormatter.compactKrw(
              summary.averageTransactionAmount,
            ),
          ),
          SizedBox(height: spacing.lg),
          _StatPair(
            label: 'HIGHEST SPEND DAY',
            value: summary.highestSpendDate == null
                ? 'NO SPENDING YET'
                : '${DateRangeUtils.monthDayLabel(summary.highestSpendDate!)} · ${CurrencyFormatter.formatKrw(summary.highestSpendAmount)}',
          ),
          SizedBox(height: spacing.lg),
          _StatPair(
            label: 'TOP CATEGORY',
            value: topCategory == null
                ? 'NO CATEGORY YET'
                : '${topCategory.name} · ${CurrencyFormatter.formatKrw(topCategory.amount)}',
          ),
          SizedBox(height: spacing.xl),
          const AppDivider(),
          SizedBox(height: spacing.md),
          const SectionHeader('CATEGORY MIX'),
          SizedBox(height: spacing.md),
          if (summary.categoryBreakdown.isEmpty)
            const MetaLabel('NO MONTHLY SPENDING YET')
          else
            for (final item in summary.categoryBreakdown.take(5)) ...[
              _CategoryBar(
                item: item,
                total: summary.totalSpent,
                onLongPress: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => CategorySpendingScreen(
                      categoryId: item.categoryId,
                      categoryName: item.name,
                      yearMonth: summary.yearMonth,
                    ),
                  ),
                ),
              ),
              SizedBox(height: spacing.md),
            ],
          SizedBox(height: spacing.lg),
          const AppDivider(),
          SizedBox(height: spacing.md),
          _StatPair(
            label: 'WISHLIST SAVED',
            value:
                '${CurrencyFormatter.formatKrw(summary.notSpent)} · ${summary.impulseBuysKilled} LET GO',
          ),
          SizedBox(height: spacing.xl),
          const AppDivider(),
          SizedBox(height: spacing.md),
          const SectionHeader('ANNUAL SPECIAL SUMMARY'),
          SizedBox(height: spacing.xs),
          MetaLabel('${DateTime.now().year} YEAR'),
          SizedBox(height: spacing.md),
          if (annualSnapshot == null)
            const MetaLabel('SET AN ANNUAL SPECIAL BUDGET IN ME')
          else ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${CurrencyFormatter.formatKrw(annualSnapshot.spentAmount)} / ${CurrencyFormatter.formatKrw(annualSnapshot.budgetAmount)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                MetaLabel(
                  'LEFT ${CurrencyFormatter.compactKrw(annualSnapshot.remainingAmount)}',
                  color:
                      annualSnapshot.remainingAmount < 0 ? colors.danger : null,
                ),
              ],
            ),
            SizedBox(height: spacing.sm),
            LinearProgressIndicator(
              value: (annualSnapshot.spentAmount / annualSnapshot.budgetAmount)
                  .clamp(0.0, 1.0),
              minHeight: 6,
              color: annualSnapshot.remainingAmount < 0
                  ? colors.danger
                  : colors.accent,
              backgroundColor: colors.divider,
            ),
            SizedBox(height: spacing.lg),
            for (final category in SpecialCategory.values) ...[
              _AnnualCategoryBar(
                label: category.label,
                amount: annualSnapshot.spentByCategory[category] ?? 0,
                total: annualSnapshot.spentAmount,
              ),
              SizedBox(height: spacing.md),
            ],
          ],
          SizedBox(height: spacing.xxl),
        ],
      ),
    );
  }
}

class _AnnualCategoryBar extends StatelessWidget {
  const _AnnualCategoryBar({
    required this.label,
    required this.amount,
    required this.total,
  });

  final String label;
  final int amount;
  final int total;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorTokens>()!;
    final ratio = total == 0 ? 0.0 : amount / total;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child:
                  Text(label, style: Theme.of(context).textTheme.titleMedium),
            ),
            MetaLabel('${(ratio * 100).round()}%'),
            const SizedBox(width: 8),
            Text(
              CurrencyFormatter.compactKrw(amount),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: ratio,
          minHeight: 4,
          color: colors.accent,
          backgroundColor: colors.divider,
        ),
      ],
    );
  }
}

class _StatPair extends StatelessWidget {
  const _StatPair({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MetaLabel(label),
        const SizedBox(height: 6),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class _CategoryBar extends StatelessWidget {
  const _CategoryBar({
    required this.item,
    required this.total,
    required this.onLongPress,
  });

  final CategorySpend item;
  final int total;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final colors = Theme.of(context).extension<AppColorTokens>()!;
    final ratio = total == 0 ? 0.0 : item.amount / total;
    return InkWell(
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                MetaLabel('${(ratio * 100).round()}%'),
                SizedBox(width: spacing.sm),
                Text(
                  CurrencyFormatter.compactKrw(item.amount),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            SizedBox(height: spacing.xs),
            LinearProgressIndicator(
              value: ratio,
              minHeight: 4,
              color: colors.accent,
              backgroundColor: colors.divider,
            ),
          ],
        ),
      ),
    );
  }
}
