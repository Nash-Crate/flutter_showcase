part of 'notifications_cubit.dart';

/// The state of the notifications feature in the application.
@freezed
class NotificationsState with _$NotificationsState {
  /// Represents the initial state of the notifications feature.
  const factory NotificationsState.initial() = _Initial;
}
