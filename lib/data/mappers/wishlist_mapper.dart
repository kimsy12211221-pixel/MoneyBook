import 'package:drift/drift.dart';

import '../../core/types/enums.dart';
import '../../domain/models/wishlist_event.dart';
import '../../domain/models/wishlist_item.dart';
import '../db/app_database.dart';

extension WishlistItemMapper on WishlistItem {
  WishlistItemsTableCompanion toCompanion() {
    return WishlistItemsTableCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      name: Value(name),
      price: Value(price),
      url: Value(url),
      imagePath: Value(imagePath),
      memo: Value(memo),
      cooldownHours: Value(cooldownHours),
      createdAt: Value(createdAt),
      cooldownUntil: Value(cooldownUntil),
      status: Value(_statusToDatabase(status)),
      waitingUntil: Value(waitingUntil),
      purchasedAt: Value(purchasedAt),
      releasedAt: Value(releasedAt),
      linkedTransactionId: Value(linkedTransactionId),
      createdDailySafeSnapshot: Value(createdDailySafeSnapshot),
      updatedAt: Value(updatedAt),
    );
  }
}

extension WishlistItemDataMapper on WishlistItemsTableData {
  WishlistItem toDomain() {
    return WishlistItem(
      id: id,
      name: name,
      price: price,
      url: url,
      imagePath: imagePath,
      memo: memo,
      cooldownHours: cooldownHours,
      createdAt: createdAt,
      cooldownUntil: cooldownUntil,
      status: _statusFromDatabase(status),
      waitingUntil: waitingUntil,
      purchasedAt: purchasedAt,
      releasedAt: releasedAt,
      linkedTransactionId: linkedTransactionId,
      createdDailySafeSnapshot: createdDailySafeSnapshot,
      updatedAt: updatedAt,
    );
  }
}

extension WishlistEventDataMapper on WishlistEventsTableData {
  WishlistEvent toDomain() {
    return WishlistEvent(
      id: id,
      wishlistItemId: wishlistItemId,
      eventType: eventType,
      eventAt: eventAt,
      payloadJson: payloadJson,
    );
  }
}

String _statusToDatabase(WishlistStatus status) {
  if (status == WishlistStatus.letGo) {
    return 'let_go';
  }
  return status.name;
}

WishlistStatus _statusFromDatabase(String value) {
  if (value == 'let_go') {
    return WishlistStatus.letGo;
  }
  return WishlistStatus.values.firstWhere(
    (item) => item.name == value,
    orElse: () => WishlistStatus.cooling,
  );
}
