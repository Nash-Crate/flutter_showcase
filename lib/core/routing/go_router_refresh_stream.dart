part of 'router.dart';

/// Bridges a [Stream] to a [Listenable] so GoRouter re-runs its redirect
/// whenever the stream emits (e.g. AuthCubit.stream).
class GoRouterRefreshStream extends ChangeNotifier {
  /// Creates a [Listenable] from a [Stream].
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    super.dispose();
  }
}
