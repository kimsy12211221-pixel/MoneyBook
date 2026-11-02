import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repositories_provider.dart';

final appLaunchProvider = FutureProvider<AppLaunchState>((ref) async {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  final appSettingsRepository = ref.watch(appSettingsRepositoryProvider);

  await categoryRepository.seedDefaultCategoriesIfNeeded();
  final setupCompleted = await appSettingsRepository.isSetupCompleted();

  return AppLaunchState(
    requiresOnboarding: !setupCompleted,
  );
});

class AppLaunchState {
  const AppLaunchState({
    required this.requiresOnboarding,
  });

  final bool requiresOnboarding;
}
