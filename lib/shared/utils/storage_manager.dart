import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum StorageKeys {
  accessToken,
  userFullName,
  roles,
  isAdmin,
  printer,
  draftReceivingCard,
  lastTime,
  id,
  kittingIndex,
  kittingDate,
}

@singleton
class StorageManager {
  StorageManager(this._preferences);

  final SharedPreferences _preferences;

  T? get<T>(StorageKeys key) {
    if (T == String) {
      return _preferences.getString(key.name) as T?;
    } else if (T == int) {
      return _preferences.getInt(key.name) as T?;
    } else if (T == bool) {
      return _preferences.getBool(key.name) as T?;
    } else if (T == double) {
      return _preferences.getInt(key.name) as T?;
    } else if (T == List<String>) {
      return _preferences.getStringList(key.name) as T?;
    } else if (T == DateTime) {
      return DateTime.tryParse(_preferences.getString(key.name) ?? '') as T?;
    }
    return _preferences.get(key.name) as T?;
  }

  void invoke(StorageKeys key) {
    _preferences.remove(key.name);
  }

  void set<T>(StorageKeys key, T value) {
    if (value is String) {
      _preferences.setString(key.name, value);
    } else if (value is int) {
      _preferences.setInt(key.name, value);
    } else if (value is double) {
      _preferences.setDouble(key.name, value);
    } else if (value is bool) {
      _preferences.setBool(key.name, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key.name, value);
    } else if (value is DateTime) {
      _preferences.setString(key.name, value.toIso8601String());
    }
  }
}
