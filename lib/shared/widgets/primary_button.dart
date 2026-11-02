import 'package:flutter/material.dart';

import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/theme_extensions.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorTokens>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final radius = Theme.of(context).extension<AppRadius>()!;

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: colors.accent,
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(
            horizontal: spacing.lg,
            vertical: spacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius.pill),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
