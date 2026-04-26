import 'package:flutter_showcase/core/storage/storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation for cache storage
@Singleton(as: ICacheStorage)
class SharedPreferencesImpl implements ICacheStorage {
  /// Constructor which takes a [SharedPreferences] instance
  const SharedPreferencesImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<bool> delete({required String key}) {
    return _prefs.remove(key);
  }

  @override
  Future<T?> read<T>({required String key}) async {
    if (T == bool) {
      return _prefs.getBool(key) as T?;
    } else if (T == double) {
      return _prefs.getDouble(key) as T?;
    } else if (T == int) {
      return _prefs.getInt(key) as T?;
    }
    return _prefs.getString(key) as T?;
  }

  @override
  Future<void> upsert<T>({required String key, required T data}) {
    if (T == bool) {
      return _prefs.setBool(key, data as bool);
    } else if (T == double) {
      return _prefs.setDouble(key, data as double);
    } else if (T == int) {
      return _prefs.setInt(key, data as int);
    }

    return _prefs.setString(key, data is String ? data : data.toString());
  }
}
