import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../shared/widgets/meta_label.dart';

class SafeSummaryRow extends StatelessWidget {
  const SafeSummaryRow({
    required this.leftLabel,
    required this.rightLabel,
    super.key,
  });

  final String leftLabel;
  final String rightLabel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorTokens>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;

    return Row(
      children: [
        Expanded(child: MetaLabel(leftLabel, color: colors.textMuted)),
        SizedBox(width: spacing.md),
        MetaLabel(rightLabel, color: colors.textMuted),
      ],
    );
  }
}
