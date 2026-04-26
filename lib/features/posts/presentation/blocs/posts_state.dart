part of 'posts_cubit.dart';

/// The state of the PostsCubit.
@freezed
abstract class PostsState with _$PostsState {
  /// constructor
  const factory PostsState({
    @Default(IMapConst({})) IMap<int, Post> posts,
    @Default(1) int page,
    @Default(10) int pageSize,
    @Default(true) bool isLoading,

    // This flag indicates whether the posts have been loaded at least once.
    @Default(false) bool initialized,
    @Default(null) String? error,
  }) = _PostsState;

  /// Initial state
  factory PostsState.initial() => const PostsState();
}
