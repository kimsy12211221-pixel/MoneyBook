import 'package:flutter/material.dart';

import '../../core/theme/theme_extensions.dart';

class HeroAmount extends StatelessWidget {
  const HeroAmount({
    required this.amount,
    this.caption,
    this.isOverBudget = false,
    super.key,
  });

  final String amount;
  final String? caption;
  final bool isOverBudget;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorTokens>()!;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 240),
          child: Text(
            amount,
            key: ValueKey<String>(amount),
            style: textTheme.displayLarge?.copyWith(
              color: isOverBudget ? colors.danger : colors.textPrimary,
            ),
          ),
        ),
        if (caption != null) ...[
          const SizedBox(height: 8),
          Text(
            caption!,
            style: textTheme.displayMedium?.copyWith(
              color: isOverBudget ? colors.danger : colors.textPrimary,
            ),
          ),
        ],
      ],
    );
  }
}
