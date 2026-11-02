import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/types/enums.dart';
import '../../core/utils/date_range_utils.dart';
import '../models/wishlist_item.dart';
import '../services/wishlist_cooldown_service.dart';
import 'current_date_provider.dart';
import 'repositories_provider.dart';

final wishlistCooldownServiceProvider =
    Provider<WishlistCooldownService>((ref) {
  return const WishlistCooldownService();
});

final activeWishlistItemsProvider = StreamProvider<List<WishlistItem>>((ref) {
  return ref.watch(wishlistRepositoryProvider).watchActiveWishlistItems();
});

final allWishlistItemsProvider = StreamProvider<List<WishlistItem>>((ref) {
  return ref.watch(wishlistRepositoryProvider).watchAllWishlistItems();
});

final currentMonthNotSpentProvider = Provider<int>((ref) {
  final items =
      ref.watch(allWishlistItemsProvider).valueOrNull ?? const <WishlistItem>[];
  final now = ref.watch(currentDateProvider).valueOrNull ?? DateTime.now();
  final yearMonth = DateRangeUtils.yearMonthKey(now);
  return items
      .where(
        (item) =>
            item.releasedAt != null &&
            DateRangeUtils.yearMonthKey(item.releasedAt!) == yearMonth,
      )
      .fold<int>(0, (sum, item) => sum + item.price);
});

final wishlistBucketsProvider = Provider<WishlistBuckets>((ref) {
  final items = ref.watch(activeWishlistItemsProvider).valueOrNull ??
      const <WishlistItem>[];
  final service = ref.watch(wishlistCooldownServiceProvider);
  final now = ref.watch(currentDateProvider).valueOrNull ?? DateTime.now();

  final cooling = <WishlistItem>[];
  final ready = <WishlistItem>[];
  final waiting = <WishlistItem>[];

  for (final item in items) {
    final status = service.resolveStatus(item, now);
    switch (status) {
      case WishlistStatus.cooling:
        cooling.add(item);
        break;
      case WishlistStatus.ready:
        ready.add(item);
        break;
      case WishlistStatus.waiting:
        waiting.add(item);
        break;
      case WishlistStatus.purchased:
      case WishlistStatus.letGo:
        break;
    }
  }

  return WishlistBuckets(cooling: cooling, ready: ready, waiting: waiting);
});

class WishlistBuckets {
  const WishlistBuckets({
    required this.cooling,
    required this.ready,
    required this.waiting,
  });

  final List<WishlistItem> cooling;
  final List<WishlistItem> ready;
  final List<WishlistItem> waiting;
}
