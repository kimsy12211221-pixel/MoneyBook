import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/meta_label.dart';
import '../../../../shared/widgets/section_header.dart';

class RecentTransactionsSection extends StatelessWidget {
  const RecentTransactionsSection({required this.items, super.key});

  final List<RecentTransactionItem> items;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader('RECENT'),
        SizedBox(height: spacing.md),
        for (final item in items) ...[
          _RecentTransactionRow(item: item),
          SizedBox(height: spacing.md),
        ],
      ],
    );
  }
}

class _RecentTransactionRow extends StatelessWidget {
  const _RecentTransactionRow({required this.item});

  final RecentTransactionItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 4),
              MetaLabel(item.category),
            ],
          ),
        ),
        Text(item.amount, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}

class RecentTransactionItem {
  const RecentTransactionItem({
    required this.title,
    required this.category,
    required this.amount,
  });

  final String title;
  final String category;
  final String amount;
}
