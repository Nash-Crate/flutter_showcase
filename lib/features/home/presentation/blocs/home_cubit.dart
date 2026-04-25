import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

part 'home_cubit.freezed.dart';

/// The HomeCubit manages the state of the home page.
@injectable
class HomeCubit extends Cubit<HomeState> {
  /// Constructor
  HomeCubit() : super(HomeState.initial());

  /// Fetch the posts
  Future<void> fetchPosts({bool isInit = false}) async {
    // If it's an initial fetch and posts are already loaded, skip fetching
    if (isInit && state.initialized) return;

    emit(state.copyWith(isLoading: true));

    // Simulate network delay
    await Future<void>.delayed(const Duration(seconds: 1));

    // Simulate fetching posts from an API
    final fetchedPosts = List.generate(state.pageSize, (index) {
      final postId = (state.page - 1) * state.pageSize + index + 1;
      return Post(
        id: '$postId',
        title: 'Post $postId',
        videoUrl: 'https://www.w3schools.com/tags/mov_bbb.mp4',
      );
    });

    emit(state.copyWith(posts: fetchedPosts, isLoading: false, initialized: true));
  }

  /// Load more posts (for pagination)
  void loadMorePosts() {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, page: state.page + 1));

    unawaited(fetchPosts());
  }
}
