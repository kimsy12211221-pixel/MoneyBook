import 'package:flutter/material.dart';

@immutable
class AppRadius extends ThemeExtension<AppRadius> {
  const AppRadius({
    required this.sm,
    required this.md,
    required this.lg,
    required this.pill,
  });

  final double sm;
  final double md;
  final double lg;
  final double pill;

  @override
  AppRadius copyWith({double? sm, double? md, double? lg, double? pill}) {
    return AppRadius(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      pill: pill ?? this.pill,
    );
  }

  @override
  AppRadius lerp(covariant ThemeExtension<AppRadius>? other, double t) {
    if (other is! AppRadius) {
      return this;
    }

    return AppRadius(
      sm: lerpDouble(sm, other.sm, t),
      md: lerpDouble(md, other.md, t),
      lg: lerpDouble(lg, other.lg, t),
      pill: lerpDouble(pill, other.pill, t),
    );
  }
}

double lerpDouble(double a, double b, double t) => a + (b - a) * t;
