import 'package:flutter/material.dart';

import '../../../../shared/widgets/meta_label.dart';

class TransactionRow extends StatelessWidget {
  const TransactionRow({
    required this.title,
    required this.meta,
    required this.amount,
    this.onTap,
    super.key,
  });

  final String title;
  final String meta;
  final String amount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 4),
                MetaLabel(meta),
              ],
            ),
          ),
          Text(amount, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
