import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

/// External library injection for transfer_data plugins.
@module
abstract class CommonExternalLibraryInjectableModule {
  /// DI for Internet connection library
  @lazySingleton
  InternetConnection get internetConnection => InternetConnection();

  /// Provides the [PackageInfo] instance for retrieving package information.
  @preResolve
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();

  /// UUID generator instance.
  @singleton
  Uuid get uuid => const Uuid();
}
