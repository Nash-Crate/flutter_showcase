import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_posts_params.freezed.dart';

/// The parameters for fetching posts.
@freezed
abstract class FetchPostsParams with _$FetchPostsParams {
  /// Constructor
  const factory FetchPostsParams({
    @Default(0) int skip,
    @Default(10) int limit,
  }) = _FetchPostsParams;
}
