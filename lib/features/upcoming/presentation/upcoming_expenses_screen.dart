import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/types/enums.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_range_utils.dart';
import '../../../domain/models/transaction.dart';
import '../../../domain/providers/category_provider.dart';
import '../../../domain/providers/repositories_provider.dart';
import '../../../domain/providers/upcoming_expense_provider.dart';
import '../../../shared/widgets/app_divider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/meta_label.dart';
import '../../../shared/widgets/section_header.dart';
import 'add_upcoming_expense_sheet.dart';

class UpcomingExpensesScreen extends ConsumerWidget {
  const UpcomingExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(upcomingExpensesProvider).valueOrNull ?? const [];
    final categories = ref.watch(categoryNameMapProvider);

    return AppScaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const AddUpcomingExpenseSheet(),
            ),
          );
        },
        label: const Text('+ UPCOMING'),
      ),
      child: ListView(
        children: [
          const SizedBox(height: 24),
          const SectionHeader('UPCOMING'),
          const SizedBox(height: 24),
          if (items.isEmpty)
            const EmptyState(title: 'NOTHING RESERVED.')
          else
            for (final item in items) ...[
              InkWell(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title,
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 4),
                    MetaLabel(
                      '${DateRangeUtils.monthDayLabel(item.scheduledDate)} · ${categories[item.categoryId]?.name ?? 'ETC'}',
                    ),
                    const SizedBox(height: 6),
                    Text(
                      CurrencyFormatter.formatKrw(item.amount),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        if (!item.isPaid)
                          OutlinedButton(
                            onPressed: () => _markPaid(ref, item.id),
                            child: const Text('MARK PAID'),
                          ),
                        if (!item.isPaid)
                          FilledButton(
                            onPressed: () => _convertToTransaction(
                                ref, item.id, item.amount, item.categoryId),
                            child: const Text('CONVERT'),
                          ),
                        if (item.isPaid) const MetaLabel('PAID'),
                        if (!item.isPaid &&
                            item.scheduledDate.isBefore(DateTime.now()))
                          const MetaLabel('OVERDUE'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const AppDivider(),
              const SizedBox(height: 16),
            ],
        ],
      ),
    );
  }

  Future<void> _markPaid(WidgetRef ref, int id) {
    return ref.read(upcomingExpenseRepositoryProvider).markAsPaid(id);
  }

  Future<void> _convertToTransaction(
    WidgetRef ref,
    int upcomingId,
    int amount,
    int? categoryId,
  ) async {
    final now = DateTime.now();
    await ref.read(transactionRepositoryProvider).createTransaction(
          SpendingTransaction(
            id: 0,
            amount: amount,
            type: TransactionType.expense,
            budgetType: BudgetType.monthly,
            specialCategory: null,
            categoryId: categoryId,
            occurredAt: now,
            memo: null,
            source: 'upcoming_converted',
            linkedUpcomingExpenseId: upcomingId,
            createdAt: now,
            updatedAt: now,
            deletedAt: null,
          ),
        );
    await ref.read(upcomingExpenseRepositoryProvider).markAsPaid(upcomingId);
  }
}
