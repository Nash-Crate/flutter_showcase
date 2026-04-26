import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/home/home.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'post_purchase_state.dart';

part 'post_purchase_cubit.freezed.dart';

/// The PostPurchaseCubit manages the state of the individual Post Purchases.
@injectable
class PostPurchaseCubit extends Cubit<PostPurchaseState> {
  /// Constructor
  PostPurchaseCubit(@factoryParam Post post, this._claimPost)
    : super(PostPurchaseState.initial(post));

  final ClaimPost _claimPost;

  /// Claim a post
  Future<void> claimPost(Post post, UserProfile profile) async {
    // If the post has a video URL, it means it's already claimed or not claimable
    if (post.videoUrl != null) return;

    emit(state.copyWith(processingState: PostPurchaseProcessingState.claiming));

    final params = ClaimPostParams(postId: post.id, userProfileId: profile.id);
    final res = await _claimPost(params);

    if (res.isLeft()) {
      emit(
        state.copyWith(
          processingState: PostPurchaseProcessingState.idle,
          error: res.asL.toString(),
        ),
      );
      return addError(res.asL);
    }

    emit(
      state.copyWith(
        processingState: PostPurchaseProcessingState.claimed,
        isPostClaimed: true,
        post: res.asR,
      ),
    );

    // clear the claimed state after a short delay to allow the UI to update
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(state.copyWith(processingState: PostPurchaseProcessingState.idle));
  }
}
