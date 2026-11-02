import 'package:flutter/material.dart';

import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_typography.dart';
import 'theme_extensions.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    final colors = AppColorTokens.light();
    return _buildTheme(Brightness.light, colors);
  }

  static ThemeData dark() {
    final colors = AppColorTokens.dark();
    return _buildTheme(Brightness.dark, colors);
  }

  static ThemeData _buildTheme(Brightness brightness, AppColorTokens colors) {
    final textTheme = AppTypography.textTheme(
      colors.textPrimary,
      colors.textMuted,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: colors.accent,
        primary: colors.accent,
        surface: colors.surface,
        error: colors.danger,
      ).copyWith(
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: colors.textPrimary,
      ),
      dividerColor: colors.divider,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[
        colors,
        const AppSpacing(
          xs: 4,
          sm: 8,
          md: 16,
          lg: 24,
          xl: 32,
          xxl: 48,
          hero: 64,
        ),
        const AppRadius(sm: 6, md: 12, lg: 18, pill: 999),
      ],
      splashFactory: NoSplash.splashFactory,
    );
  }
}
