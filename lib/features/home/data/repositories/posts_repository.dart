import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/home/home.dart';
import 'package:injectable/injectable.dart';

/// Repository for posts
@Singleton(as: IPostsRepository)
class PostsRepository implements IPostsRepository {
  /// Constructor
  const PostsRepository(this._datasource);

  final PostsDatasource _datasource;

  @override
  AsyncFailT<Post> claimPost(ClaimPostParams params) {
    return _datasource.claimPost(params);
  }

  @override
  AsyncFailT<List<Post>> fetchPosts(FetchPostsParams params) {
    return _datasource.fetchPosts(params);
  }
}
