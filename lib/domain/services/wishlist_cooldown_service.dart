import '../../core/types/enums.dart';
import '../models/wishlist_item.dart';

class WishlistCooldownService {
  const WishlistCooldownService();

  WishlistStatus resolveStatus(WishlistItem item, DateTime now) {
    if (item.status == WishlistStatus.purchased ||
        item.status == WishlistStatus.letGo) {
      return item.status;
    }

    if (item.status == WishlistStatus.cooling &&
        !now.isBefore(item.cooldownUntil)) {
      return WishlistStatus.ready;
    }

    if (item.status == WishlistStatus.waiting &&
        item.waitingUntil != null &&
        !now.isBefore(item.waitingUntil!)) {
      return WishlistStatus.ready;
    }

    return item.status;
  }

  Duration remainingTime(WishlistItem item, DateTime now) {
    final target = item.status == WishlistStatus.waiting
        ? item.waitingUntil ?? item.cooldownUntil
        : item.cooldownUntil;

    if (!target.isAfter(now)) {
      return Duration.zero;
    }

    return target.difference(now);
  }

  DateTime buildWaitingUntil(DateTime now, Duration duration) {
    return now.add(duration);
  }
}
