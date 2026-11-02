import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_settings_keys.dart';
import '../models/budget_widget_style.dart';
import 'repositories_provider.dart';

final budgetWidgetStyleProvider = StreamProvider<BudgetWidgetStyle>((ref) {
  return ref
      .watch(appSettingsRepositoryProvider)
      .watchSetting(AppSettingsKeys.budgetWidgetStyle)
      .map((setting) => BudgetWidgetStyle.fromKey(setting?.value));
});
