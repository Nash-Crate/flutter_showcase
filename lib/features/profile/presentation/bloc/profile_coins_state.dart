part of 'profile_coins_cubit.dart';

/// State class for managing the state of profile coins.
@freezed
abstract class ProfileCoinsState with _$ProfileCoinsState {
  /// Constructor
  const factory ProfileCoinsState({
    @Default(0) double coins,
    @Default(null) String? error,
  }) = _ProfileCoinsState;

  /// Initial state
  factory ProfileCoinsState.initial() => const ProfileCoinsState();
}
