import 'package:app_links/app_links.dart';
import 'package:injectable/injectable.dart';

/// External library injection for deep-links and app-links
@module
abstract class LinksExternalLibraryInjectableModule {
  /// Injects AppLinks instance for handling app links.
  @singleton
  AppLinks res() => AppLinks();
}
