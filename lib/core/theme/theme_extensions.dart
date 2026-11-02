import 'package:flutter/material.dart';

import 'app_colors.dart';

@immutable
class AppColorTokens extends ThemeExtension<AppColorTokens> {
  const AppColorTokens({
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textMuted,
    required this.divider,
    required this.accent,
    required this.danger,
  });

  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textMuted;
  final Color divider;
  final Color accent;
  final Color danger;

  factory AppColorTokens.light() {
    return const AppColorTokens(
      background: AppColors.lightBackground,
      surface: AppColors.lightSurface,
      textPrimary: AppColors.lightTextPrimary,
      textMuted: AppColors.lightTextMuted,
      divider: AppColors.lightDivider,
      accent: AppColors.accent,
      danger: AppColors.danger,
    );
  }

  factory AppColorTokens.dark() {
    return const AppColorTokens(
      background: AppColors.darkBackground,
      surface: AppColors.darkSurface,
      textPrimary: AppColors.darkTextPrimary,
      textMuted: AppColors.darkTextMuted,
      divider: AppColors.darkDivider,
      accent: AppColors.accent,
      danger: AppColors.danger,
    );
  }

  @override
  AppColorTokens copyWith({
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textMuted,
    Color? divider,
    Color? accent,
    Color? danger,
  }) {
    return AppColorTokens(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      divider: divider ?? this.divider,
      accent: accent ?? this.accent,
      danger: danger ?? this.danger,
    );
  }

  @override
  AppColorTokens lerp(
    covariant ThemeExtension<AppColorTokens>? other,
    double t,
  ) {
    if (other is! AppColorTokens) {
      return this;
    }

    return AppColorTokens(
      background: Color.lerp(background, other.background, t) ?? background,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textMuted: Color.lerp(textMuted, other.textMuted, t) ?? textMuted,
      divider: Color.lerp(divider, other.divider, t) ?? divider,
      accent: Color.lerp(accent, other.accent, t) ?? accent,
      danger: Color.lerp(danger, other.danger, t) ?? danger,
    );
  }
}
