part of 'home_cubit.dart';

/// The state of the HomeCubit.
@freezed
abstract class HomeState with _$HomeState {
  /// constructor
  const factory HomeState({
    @Default([]) List<Post> posts,
    @Default(1) int page,
    @Default(10) int pageSize,
    @Default(true) bool isLoading,

    // This flag indicates whether the posts have been loaded at least once.
    @Default(false) bool initialized,
  }) = _HomeState;

  /// Initial state
  factory HomeState.initial() => const HomeState();
}
