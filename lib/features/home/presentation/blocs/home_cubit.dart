import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/home/home.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

part 'home_cubit.freezed.dart';

/// The HomeCubit manages the state of the home page.
@injectable
class HomeCubit extends Cubit<HomeState> {
  /// Constructor
  HomeCubit(this._fetchPosts) : super(HomeState.initial());

  final FetchPosts _fetchPosts;

  /// Fetch the posts
  Future<void> fetchPosts({bool isInit = false}) async {
    // If it's an initial fetch and posts are already loaded, skip fetching
    if (isInit && state.initialized) return;

    emit(state.copyWith(isLoading: true));

    final params = FetchPostsParams(skip: (state.page - 1) * state.pageSize, limit: state.pageSize);
    final res = await _fetchPosts(params);

    if (res.isLeft()) {
      return emit(state.copyWith(isLoading: false, error: res.asL.toString()));
    }

    // Convert the list of posts to a map for easier updates
    final postsMap = IMap.fromValues(keyMapper: (p) => p.id, values: res.asR);

    emit(
      state.copyWith(
        posts: isInit ? postsMap : state.posts.addAll(postsMap),
        isLoading: false,
        initialized: true,
      ),
    );
  }

  /// Load more posts (for pagination)
  void loadMorePosts() {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, page: state.page + 1));

    unawaited(fetchPosts());
  }

  /// set a post as claimed
  void postClaimed(Post claimedPost) {
    emit(state.copyWith(posts: state.posts.add(claimedPost.id, claimedPost)));
  }
}
