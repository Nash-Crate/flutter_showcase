import 'package:flutter_showcase/logger.dart';

/// Converts a raw deep-link / app-link URI string (as captured by `app_links`)
/// into an in-app go_router location such as `/posts/123`.
///
/// Handles both link styles declared in the native manifests:
///  * App Links — `https://nashcrate.com/flutter_showcase/posts/123`
///    (path carries the [_appLinkPathPrefix] which is stripped)
///  * Custom scheme — `nashcrate://open.my.showcase/posts/123`
///    (host is just a disambiguator; the path is already the route)
abstract final class DeepLinkResolver {
  /// App Links arrive under this path prefix — see the app-link intent-filter
  /// in `android/app/src/main/AndroidManifest.xml`
  /// (`android:pathPrefix="/flutter_showcase"`).
  static const _appLinkPathPrefix = '/flutter_showcase';

  /// Maps [rawLink] to a router location, or `null` when it can't be mapped to
  /// a meaningful in-app destination (caller should then do nothing).
  static String? toLocation(String rawLink) {
    final uri = Uri.tryParse(rawLink);
    if (uri == null) {
      logger.w('DeepLinkResolver: could not parse "$rawLink"');
      return null;
    }

    var path = uri.path;
    if (path.startsWith(_appLinkPathPrefix)) {
      path = path.substring(_appLinkPathPrefix.length);
    }

    // Nothing actionable (bare domain / scheme) — let the app open normally.
    if (path.isEmpty || path == '/') return null;

    return uri.hasQuery ? '$path?${uri.query}' : path;
  }
}
