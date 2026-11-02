import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';

enum SpendingPeriod { today, week, month }

class PeriodSwitcher extends StatelessWidget {
  const PeriodSwitcher({
    required this.selectedPeriod,
    required this.onChanged,
    super.key,
  });

  final SpendingPeriod selectedPeriod;
  final ValueChanged<SpendingPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;

    return Wrap(
      spacing: spacing.sm,
      children: SpendingPeriod.values.map((period) {
        return _PeriodChip(
          label: period.name.toUpperCase(),
          isSelected: period == selectedPeriod,
          onTap: () => onChanged(period),
        );
      }).toList(),
    );
  }
}

class _PeriodChip extends StatelessWidget {
  const _PeriodChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorTokens>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final radius = Theme.of(context).extension<AppRadius>()!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius.pill),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: spacing.md,
          vertical: spacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? colors.accent : Colors.transparent,
          border: Border.all(
            color: isSelected ? colors.accent : colors.divider,
          ),
          borderRadius: BorderRadius.circular(radius.pill),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isSelected ? Colors.black : colors.textPrimary,
              ),
        ),
      ),
    );
  }
}
