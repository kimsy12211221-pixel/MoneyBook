import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import 'meta_label.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({required this.title, this.detail, super.key});

  final String title;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MetaLabel(title),
          if (detail != null) ...[
            SizedBox(height: spacing.sm),
            Text(detail!, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}
