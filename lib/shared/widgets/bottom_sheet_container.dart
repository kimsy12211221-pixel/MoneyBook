import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(spacing.lg),
        child: child,
      ),
    );
  }
}
