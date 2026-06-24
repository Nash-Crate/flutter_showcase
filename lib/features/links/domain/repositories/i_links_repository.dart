import 'package:flutter_showcase/core/core.dart';

/// abstract mixin for
mixin ILinksRepository {
  /// initialize and listen to deep-links and app-links
  StreamFailT<String> initAndListenLinks();
}
