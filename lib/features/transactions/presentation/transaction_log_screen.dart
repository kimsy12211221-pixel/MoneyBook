import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/types/enums.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_range_utils.dart';
import '../../../domain/providers/category_provider.dart';
import '../../../domain/providers/transaction_provider.dart';
import '../../../shared/widgets/app_divider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/meta_label.dart';
import '../../../shared/widgets/section_header.dart';
import 'add_transaction_sheet.dart';
import 'edit_transaction_screen.dart';
import 'widgets/transaction_row.dart';

class TransactionLogScreen extends ConsumerStatefulWidget {
  const TransactionLogScreen({super.key});

  @override
  ConsumerState<TransactionLogScreen> createState() =>
      _TransactionLogScreenState();
}

class _TransactionLogScreenState extends ConsumerState<TransactionLogScreen> {
  late DateTime _selectedMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month);
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final yearMonth = DateRangeUtils.yearMonthKey(_selectedMonth);
    final transactions =
        ref.watch(transactionsForMonthProvider(yearMonth)).valueOrNull ??
            const [];
    final categoryMap = ref.watch(categoryNameMapProvider);

    return AppScaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const AddTransactionSheet(),
            ),
          );
        },
        label: const Text('+ ADD'),
      ),
      child: ListView(
        children: [
          SizedBox(height: spacing.lg),
          const SectionHeader('LOG'),
          SizedBox(height: spacing.sm),
          Row(
            children: [
              IconButton(
                tooltip: 'PREVIOUS MONTH',
                onPressed: () => setState(() {
                  _selectedMonth = DateTime(
                    _selectedMonth.year,
                    _selectedMonth.month - 1,
                  );
                }),
                icon: const Icon(Icons.chevron_left),
              ),
              Expanded(
                child: Center(child: MetaLabel(yearMonth)),
              ),
              IconButton(
                tooltip: 'NEXT MONTH',
                onPressed: _isCurrentMonth
                    ? null
                    : () => setState(() {
                          _selectedMonth = DateTime(
                            _selectedMonth.year,
                            _selectedMonth.month + 1,
                          );
                        }),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          SizedBox(height: spacing.xl),
          const SectionHeader('RECENT'),
          SizedBox(height: spacing.md),
          if (transactions.isEmpty)
            const EmptyState(title: 'NOTHING SPENT YET.')
          else
            for (final item in transactions) ...[
              TransactionRow(
                title: item.memo ??
                    categoryMap[item.categoryId]?.name ??
                    'EXPENSE',
                meta:
                    '${categoryMap[item.categoryId]?.name ?? 'ETC'} · ${item.budgetType == BudgetType.annualSpecial ? 'ANNUAL SPECIAL · ${item.specialCategory?.label ?? 'OTHER'}' : DateRangeUtils.monthDayLabel(item.occurredAt)}',
                amount: '-${CurrencyFormatter.formatKrw(item.amount)}',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => EditTransactionScreen(transaction: item),
                    ),
                  );
                },
              ),
              SizedBox(height: spacing.md),
              const AppDivider(),
              SizedBox(height: spacing.md),
            ],
        ],
      ),
    );
  }

  bool get _isCurrentMonth {
    final now = DateTime.now();
    return _selectedMonth.year == now.year && _selectedMonth.month == now.month;
  }
}
