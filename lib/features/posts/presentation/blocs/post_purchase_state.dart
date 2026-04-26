part of 'post_purchase_cubit.dart';

/// The state of the PostPurchaseCubit.
@freezed
abstract class PostPurchaseState with _$PostPurchaseState {
  /// Constructor
  const factory PostPurchaseState({
    required Post post,
    @Default(PostPurchaseProcessingState.idle) PostPurchaseProcessingState processingState,
    @Default(false) bool isPostClaimed,
    @Default(null) String? error,
  }) = _PostPurchaseState;

  /// Initial state
  factory PostPurchaseState.initial(Post post) => PostPurchaseState(post: post);
}

/// The processing state of a post purchase action.
enum PostPurchaseProcessingState {
  /// No action is being processed.
  idle,

  /// The post is being claimed
  claiming,

  /// The post is claimed
  claimed,
}
