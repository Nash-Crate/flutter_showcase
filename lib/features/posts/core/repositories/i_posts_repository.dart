import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/posts/posts.dart';

/// abstract repository for post actions
mixin IPostsRepository {
  /// Fetch a list of posts based on the provided parameters
  AsyncFailT<List<Post>> fetchPosts(FetchPostsParams params);

  /// Claim a post by its ID for a user profile
  AsyncFailT<Post> claimPost(ClaimPostParams params);
}
