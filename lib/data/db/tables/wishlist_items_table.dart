import 'package:drift/drift.dart';

class WishlistItemsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get price => integer()();
  TextColumn get url => text().nullable()();
  TextColumn get imagePath => text().nullable()();
  TextColumn get memo => text().nullable()();
  IntColumn get cooldownHours => integer().withDefault(const Constant(72))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get cooldownUntil => dateTime()();
  TextColumn get status => text()();
  DateTimeColumn get waitingUntil => dateTime().nullable()();
  DateTimeColumn get purchasedAt => dateTime().nullable()();
  DateTimeColumn get releasedAt => dateTime().nullable()();
  IntColumn get linkedTransactionId => integer().nullable()();
  IntColumn get createdDailySafeSnapshot =>
      integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime()();
}
