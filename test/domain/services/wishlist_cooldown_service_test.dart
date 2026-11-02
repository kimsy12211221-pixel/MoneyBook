import 'package:flutter_test/flutter_test.dart';
import 'package:personal_spending_app/core/types/enums.dart';
import 'package:personal_spending_app/domain/models/wishlist_item.dart';
import 'package:personal_spending_app/domain/services/wishlist_cooldown_service.dart';

void main() {
  const service = WishlistCooldownService();

  group('WishlistCooldownService', () {
    test('moves cooling item to ready when cooldown passes', () {
      final now = DateTime(2026, 8, 31, 10);
      final item = WishlistItem(
        id: 1,
        name: 'HEADPHONES',
        price: 349000,
        url: null,
        imagePath: null,
        memo: null,
        cooldownHours: 72,
        createdAt: DateTime(2026, 8, 28, 9),
        cooldownUntil: DateTime(2026, 8, 31, 9),
        status: WishlistStatus.cooling,
        waitingUntil: null,
        purchasedAt: null,
        releasedAt: null,
        linkedTransactionId: null,
        createdDailySafeSnapshot: 42000,
        updatedAt: DateTime(2026, 8, 28, 9),
      );

      expect(service.resolveStatus(item, now), WishlistStatus.ready);
    });

    test('keeps waiting item waiting before waitingUntil', () {
      final now = DateTime(2026, 8, 31, 10);
      final item = WishlistItem(
        id: 1,
        name: 'SNEAKERS',
        price: 189000,
        url: null,
        imagePath: null,
        memo: null,
        cooldownHours: 72,
        createdAt: DateTime(2026, 8, 28, 9),
        cooldownUntil: DateTime(2026, 8, 31, 9),
        status: WishlistStatus.waiting,
        waitingUntil: DateTime(2026, 9, 3, 10),
        purchasedAt: null,
        releasedAt: null,
        linkedTransactionId: null,
        createdDailySafeSnapshot: 42000,
        updatedAt: DateTime(2026, 8, 31, 9),
      );

      expect(service.resolveStatus(item, now), WishlistStatus.waiting);
      expect(service.remainingTime(item, now), const Duration(days: 3));
    });
  });
}
