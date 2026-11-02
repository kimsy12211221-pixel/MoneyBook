import '../constants/app_constants.dart';

class CurrencyFormatter {
  const CurrencyFormatter._();

  static String formatKrw(int amount) {
    final negative = amount < 0;
    final digits = amount.abs().toString();
    final buffer = StringBuffer();

    for (var index = 0; index < digits.length; index++) {
      final reverseIndex = digits.length - index;
      buffer.write(digits[index]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write(',');
      }
    }

    return '${negative ? '-' : ''}${AppConstants.defaultCurrencySymbol}${buffer.toString()}';
  }

  static String compactKrw(int amount) {
    final absAmount = amount.abs();
    final sign = amount < 0 ? '-' : '';

    if (absAmount >= 1000000) {
      final value = (absAmount / 1000000).toStringAsFixed(
        absAmount >= 10000000 ? 0 : 1,
      );
      return '$sign${AppConstants.defaultCurrencySymbol}${_trimTrailingZero(value)}M';
    }

    if (absAmount >= 1000) {
      final value = (absAmount / 1000).toStringAsFixed(
        absAmount >= 10000 ? 0 : 1,
      );
      return '$sign${AppConstants.defaultCurrencySymbol}${_trimTrailingZero(value)}K';
    }

    return formatKrw(amount);
  }

  static String _trimTrailingZero(String value) {
    if (!value.contains('.')) {
      return value;
    }

    return value.replaceFirst(RegExp(r'\.?0+$'), '');
  }
}
