import 'package:drift/drift.dart';

import 'wishlist_items_table.dart';

class WishlistEventsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wishlistItemId =>
      integer().references(WishlistItemsTable, #id)();
  TextColumn get eventType => text()();
  DateTimeColumn get eventAt => dateTime()();
  TextColumn get payloadJson => text().nullable()();
}
