import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../core/types/enums.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../domain/providers/annual_special_provider.dart';
import '../../../shared/widgets/app_divider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/meta_label.dart';
import '../../../shared/widgets/section_header.dart';

class AnnualSpecialDetailScreen extends ConsumerWidget {
  const AnnualSpecialDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final colors = Theme.of(context).extension<AppColorTokens>()!;
    final snapshot = ref.watch(annualSpecialSnapshotProvider).valueOrNull;

    return AppScaffold(
      child: ListView(
        children: [
          SizedBox(height: spacing.lg),
          const SectionHeader('ANNUAL SPECIAL'),
          SizedBox(height: spacing.sm),
          MetaLabel('${DateTime.now().year} YEAR'),
          SizedBox(height: spacing.xl),
          Text(
            snapshot == null
                ? 'NOT SET'
                : CurrencyFormatter.formatKrw(snapshot.remainingAmount),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: snapshot != null && snapshot.remainingAmount < 0
                      ? colors.danger
                      : colors.textPrimary,
                ),
          ),
          SizedBox(height: spacing.xs),
          MetaLabel(
            snapshot == null
                ? 'SET AN ANNUAL SPECIAL BUDGET IN ME'
                : '사용 ${CurrencyFormatter.formatKrw(snapshot.spentAmount)} / 예산 ${CurrencyFormatter.formatKrw(snapshot.budgetAmount)}',
          ),
          SizedBox(height: spacing.xl),
          const AppDivider(),
          SizedBox(height: spacing.md),
          for (final category in SpecialCategory.values) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    category.label,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  CurrencyFormatter.formatKrw(
                    snapshot?.spentByCategory[category] ?? 0,
                  ),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            SizedBox(height: spacing.md),
            const AppDivider(),
            SizedBox(height: spacing.md),
          ],
        ],
      ),
    );
  }
}
