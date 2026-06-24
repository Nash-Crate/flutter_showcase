import 'package:flutter_showcase/core/core.dart';
import 'package:fpdart/fpdart.dart';

/// Abstract mixing that defines the interface for the notifications repository
mixin INotificationsRepository {
  /// Initializes the notifications system and returns an [AsyncFailT] that indicates success or failure.
  AsyncFailT<Unit> initializeNotifications();
}
