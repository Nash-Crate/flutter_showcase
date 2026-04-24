import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// External library injection for data persistence related dependencies.
@module
abstract class DataPersistenceExternalLibraryInjectableModule {
  /// DI for SharedPreferences library
  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();
}
