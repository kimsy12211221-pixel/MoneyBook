import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import '../domain/providers/app_launch_provider.dart';
import 'router.dart';

class PersonalSpendingApp extends ConsumerWidget {
  const PersonalSpendingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final launchState = ref.watch(appLaunchProvider);

    return MaterialApp(
      title: 'Personal Spending App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.light(),
      home: AppRouter(launchState: launchState),
    );
  }
}
