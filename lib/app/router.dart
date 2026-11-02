import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/navigation/app_shell.dart';
import '../domain/providers/app_launch_provider.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({
    required this.launchState,
    super.key,
  });

  final AsyncValue<AppLaunchState> launchState;

  @override
  Widget build(BuildContext context) {
    return launchState.when(
      data: (state) {
        if (state.requiresOnboarding) {
          return const OnboardingScreen();
        }

        return const AppShell();
      },
      loading: () => const _LaunchLoadingScreen(),
      error: (error, stackTrace) => _LaunchErrorScreen(error: error),
    );
  }
}

class _LaunchLoadingScreen extends StatelessWidget {
  const _LaunchLoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _LaunchErrorScreen extends StatelessWidget {
  const _LaunchErrorScreen({
    required this.error,
  });

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'FAILED TO LOAD APP\n$error',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
