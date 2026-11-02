import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:personal_spending_app/core/theme/app_theme.dart';

void main() {
  test('uses the white and green light theme', () {
    final theme = AppTheme.light();

    expect(theme.brightness, Brightness.light);
    expect(theme.scaffoldBackgroundColor, Colors.white);
    expect(theme.colorScheme.primary, isNot(Colors.black));
  });
}
