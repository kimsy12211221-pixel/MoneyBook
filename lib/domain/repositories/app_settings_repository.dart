import '../models/app_setting.dart';

abstract class AppSettingsRepository {
  Future<AppSetting?> getSetting(String key);
  Stream<AppSetting?> watchSetting(String key);
  Future<void> setSetting(String key, String value);
  Future<bool> isSetupCompleted();
}
