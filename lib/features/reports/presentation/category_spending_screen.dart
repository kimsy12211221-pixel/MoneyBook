import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/types/enums.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_range_utils.dart';
import '../../../domain/providers/transaction_provider.dart';
import '../../../shared/widgets/app_divider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/meta_label.dart';
import '../../../shared/widgets/section_header.dart';
import '../../transactions/presentation/edit_transaction_screen.dart';
import '../../transactions/presentation/widgets/transaction_row.dart';

class CategorySpendingScreen extends ConsumerWidget {
  const CategorySpendingScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.yearMonth,
  });

  final int categoryId;
  final String categoryName;
  final String yearMonth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final transactions =
        ref.watch(transactionsForMonthProvider(yearMonth)).valueOrNull ??
            const [];
    final items = transactions
        .where(
          (item) =>
              item.budgetType == BudgetType.monthly &&
              item.categoryId == categoryId,
        )
        .toList(growable: false);
    final total = items.fold<int>(0, (sum, item) => sum + item.amount);

    return AppScaffold(
      child: ListView(
        children: [
          SizedBox(height: spacing.lg),
          SectionHeader('$categoryName SPENDING'),
          SizedBox(height: spacing.sm),
          MetaLabel('$yearMonth · ${items.length} PAYMENTS'),
          SizedBox(height: spacing.md),
          Text(
            CurrencyFormatter.formatKrw(total),
            style: Theme.of(context).textTheme.displaySmall,
          ),
          SizedBox(height: spacing.xl),
          if (items.isEmpty)
            const EmptyState(title: 'NO SPENDING IN THIS CATEGORY.')
          else
            for (final item in items) ...[
              TransactionRow(
                title: item.memo ?? categoryName,
                meta: DateRangeUtils.monthDayLabel(item.occurredAt),
                amount: '-${CurrencyFormatter.formatKrw(item.amount)}',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => EditTransactionScreen(transaction: item),
                  ),
                ),
              ),
              SizedBox(height: spacing.md),
              const AppDivider(),
              SizedBox(height: spacing.md),
            ],
          SizedBox(height: spacing.xxl),
        ],
      ),
    );
  }
}
