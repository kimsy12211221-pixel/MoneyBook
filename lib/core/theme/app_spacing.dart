import 'package:flutter/material.dart';

@immutable
class AppSpacing extends ThemeExtension<AppSpacing> {
  const AppSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.hero,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double hero;

  @override
  AppSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? hero,
  }) {
    return AppSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      hero: hero ?? this.hero,
    );
  }

  @override
  AppSpacing lerp(covariant ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) {
      return this;
    }

    return AppSpacing(
      xs: lerpDouble(xs, other.xs, t),
      sm: lerpDouble(sm, other.sm, t),
      md: lerpDouble(md, other.md, t),
      lg: lerpDouble(lg, other.lg, t),
      xl: lerpDouble(xl, other.xl, t),
      xxl: lerpDouble(xxl, other.xxl, t),
      hero: lerpDouble(hero, other.hero, t),
    );
  }
}

double lerpDouble(double a, double b, double t) => a + (b - a) * t;
