import 'package:flutter/material.dart';

class AppTypography {
  const AppTypography._();

  static TextTheme textTheme(Color textColor, Color mutedColor) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 72,
        height: 0.94,
        fontWeight: FontWeight.w800,
        color: textColor,
        letterSpacing: -2.4,
      ),
      displayMedium: TextStyle(
        fontSize: 34,
        height: 1.0,
        fontWeight: FontWeight.w800,
        color: textColor,
        letterSpacing: -1.2,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        height: 1.1,
        fontWeight: FontWeight.w700,
        color: textColor,
        letterSpacing: -0.8,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        height: 1.2,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.35,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.35,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelLarge: TextStyle(
        fontSize: 12,
        height: 1.2,
        fontWeight: FontWeight.w700,
        color: textColor,
        letterSpacing: 1.1,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        height: 1.2,
        fontWeight: FontWeight.w600,
        color: mutedColor,
        letterSpacing: 1.3,
      ),
    );
  }
}
