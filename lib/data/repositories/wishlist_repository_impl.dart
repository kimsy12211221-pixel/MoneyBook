import 'dart:convert';

import 'package:drift/drift.dart';

import '../../domain/models/wishlist_item.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../db/app_database.dart';
import '../mappers/wishlist_mapper.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  const WishlistRepositoryImpl(this._database);

  final AppDatabase _database;

  @override
  Future<void> createWishlistItem(WishlistItem item) async {
    final id = await _database
        .into(_database.wishlistItemsTable)
        .insert(item.toCompanion());
    await _database.into(_database.wishlistEventsTable).insert(
          WishlistEventsTableCompanion.insert(
            wishlistItemId: id,
            eventType: 'created',
            eventAt: item.createdAt,
            payloadJson: const Value(null),
          ),
        );
  }

  @override
  Future<void> markLetGo(int id) async {
    final now = DateTime.now();
    await (_database.update(_database.wishlistItemsTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(
      WishlistItemsTableCompanion(
        status: const Value('let_go'),
        releasedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
    await _database.into(_database.wishlistEventsTable).insert(
          WishlistEventsTableCompanion.insert(
            wishlistItemId: id,
            eventType: 'let_go',
            eventAt: now,
            payloadJson: const Value(null),
          ),
        );
  }

  @override
  Future<void> markPurchased(int id, {int? linkedTransactionId}) async {
    final now = DateTime.now();
    await (_database.update(_database.wishlistItemsTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(
      WishlistItemsTableCompanion(
        status: const Value('purchased'),
        purchasedAt: Value(now),
        linkedTransactionId: Value(linkedTransactionId),
        updatedAt: Value(now),
      ),
    );
    await _database.into(_database.wishlistEventsTable).insert(
          WishlistEventsTableCompanion.insert(
            wishlistItemId: id,
            eventType: 'purchased',
            eventAt: now,
            payloadJson: Value(
              linkedTransactionId == null
                  ? null
                  : jsonEncode({'linkedTransactionId': linkedTransactionId}),
            ),
          ),
        );
  }

  @override
  Future<int> sumLetGoAmountForMonth(String yearMonth) async {
    final parts = yearMonth.split('-');
    final month = DateTime(int.parse(parts[0]), int.parse(parts[1]));
    final start = DateTime(month.year, month.month);
    final end = DateTime(month.year, month.month + 1, 0, 23, 59, 59, 999);

    final query = _database.select(_database.wishlistItemsTable)
      ..where((tbl) =>
          tbl.status.equals('let_go') &
          tbl.releasedAt.isNotNull() &
          tbl.releasedAt.isBiggerOrEqualValue(start) &
          tbl.releasedAt.isSmallerOrEqualValue(end));
    final rows = await query.get();
    return rows.fold<int>(0, (sum, item) => sum + item.price);
  }

  @override
  Future<void> waitMore(int id, Duration duration) async {
    final now = DateTime.now();
    final waitingUntil = now.add(duration);
    await (_database.update(_database.wishlistItemsTable)
          ..where((tbl) => tbl.id.equals(id)))
        .write(
      WishlistItemsTableCompanion(
        status: const Value('waiting'),
        waitingUntil: Value(waitingUntil),
        updatedAt: Value(now),
      ),
    );
    await _database.into(_database.wishlistEventsTable).insert(
          WishlistEventsTableCompanion.insert(
            wishlistItemId: id,
            eventType: 'wait_more',
            eventAt: now,
            payloadJson: Value(jsonEncode({'hours': duration.inHours})),
          ),
        );
  }

  @override
  Stream<List<WishlistItem>> watchActiveWishlistItems() {
    final query = _database.select(_database.wishlistItemsTable)
      ..where((tbl) => tbl.status.isNotIn(const ['purchased', 'let_go']))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.cooldownUntil)]);

    return _mapRows(query.watch());
  }

  @override
  Stream<List<WishlistItem>> watchAllWishlistItems() {
    final query = _database.select(_database.wishlistItemsTable)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]);

    return _mapRows(query.watch());
  }

  Stream<List<WishlistItem>> _mapRows(
      Stream<List<WishlistItemsTableData>> source) {
    return source.map(
      (rows) => rows.map((item) => item.toDomain()).toList(growable: false),
    );
  }
}
