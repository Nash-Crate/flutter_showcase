import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/home/home.dart';
import 'package:injectable/injectable.dart';

/// The parameters for fetching posts.
@singleton
class FetchPosts implements Usecase<List<Post>, FetchPostsParams> {
  /// Constructor
  const FetchPosts(this._repository);
  final IPostsRepository _repository;

  @override
  AsyncFailT<List<Post>> call(FetchPostsParams params) {
    return _repository.fetchPosts(params);
  }
}
