import 'package:flutter/services.dart';

class BudgetWidgetSync {
  const BudgetWidgetSync._();

  static const _channel = MethodChannel('personal_spending/widget');

  static Future<void> update({
    required int budget,
    required int spent,
    required int creditBalance,
    required int dailyCredit,
    required int monthlyAvailable,
    String? style,
  }) async {
    try {
      await _channel.invokeMethod<void>('updateBudgetWidget', {
        'budget': budget,
        'spent': spent,
        'creditBalance': creditBalance,
        'dailyCredit': dailyCredit,
        'monthlyAvailable': monthlyAvailable,
        if (style != null) 'style': style,
      });
    } on MissingPluginException {
      // The widget bridge is Android-only; other Flutter targets can ignore it.
    }
  }

  static Future<void> setStyle(String style) async {
    try {
      await _channel.invokeMethod<void>('setBudgetWidgetStyle', {
        'style': style,
      });
    } on MissingPluginException {
      // The widget bridge is Android-only; other Flutter targets can ignore it.
    }
  }
}
