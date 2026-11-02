import 'package:drift/drift.dart';

import '../../core/constants/app_settings_keys.dart';
import '../../domain/models/app_setting.dart';
import '../../domain/repositories/app_settings_repository.dart';
import '../db/app_database.dart';

class AppSettingsRepositoryImpl implements AppSettingsRepository {
  const AppSettingsRepositoryImpl(this._database);

  final AppDatabase _database;

  @override
  Future<AppSetting?> getSetting(String key) async {
    final query = _database.select(_database.appSettingsTable)
      ..where((tbl) => tbl.key.equals(key));
    final row = await query.getSingleOrNull();
    if (row == null) {
      return null;
    }

    return AppSetting(
      key: row.key,
      value: row.value,
      updatedAt: row.updatedAt,
    );
  }

  @override
  Future<bool> isSetupCompleted() async {
    final setting = await getSetting(AppSettingsKeys.setupCompleted);
    return setting?.value == 'true';
  }

  @override
  Future<void> setSetting(String key, String value) async {
    await _database.into(_database.appSettingsTable).insertOnConflictUpdate(
          AppSettingsTableCompanion(
            key: Value(key),
            value: Value(value),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  @override
  Stream<AppSetting?> watchSetting(String key) {
    final query = _database.select(_database.appSettingsTable)
      ..where((tbl) => tbl.key.equals(key));

    return query.watchSingleOrNull().map((row) {
      if (row == null) {
        return null;
      }

      return AppSetting(
        key: row.key,
        value: row.value,
        updatedAt: row.updatedAt,
      );
    });
  }
}
