import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class SummaryPosterCard extends StatelessWidget {
  const SummaryPosterCard({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final radius = Theme.of(context).extension<AppRadius>()!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.lg),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: child,
    );
  }
}
