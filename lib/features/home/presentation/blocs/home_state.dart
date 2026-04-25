part of 'home_cubit.dart';

/// The state of the HomeCubit.
@freezed
abstract class HomeState with _$HomeState {
  /// constructor
  const factory HomeState() = _HomeState;

  /// Initial state
  factory HomeState.initial() => const HomeState();
}
