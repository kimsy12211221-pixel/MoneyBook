import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.child,
    this.floatingActionButton,
    super.key,
  });

  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;

    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing.lg),
          child: child,
        ),
      ),
    );
  }
}
