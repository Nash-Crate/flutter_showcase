import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/posts/posts.dart';
import 'package:flutter_showcase/logger.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Datasource for posts
abstract class PostsDatasource with IPostsRepository {}

/// Implementation of [PostsDatasource]
@Singleton(as: PostsDatasource)
class PostsDatasourceImpl implements PostsDatasource {
  /// Constructor
  const PostsDatasourceImpl(this._supabaseClient, this._cacheStorage);

  final supabase.SupabaseClient _supabaseClient;
  final ICacheStorage _cacheStorage;

  @override
  AsyncFailT<Post> claimPost(ClaimPostParams params) async {
    try {
      // update post as claimed
      final claimedPostJson = await _supabaseClient.rpc<Map<String, dynamic>>(
        'claim_post',
        params: {
          'p_profile_id': params.userProfileId,
          'p_post_id': params.postId,
        },
      );

      final updatedPost = PostModel.fromJson(claimedPostJson).toDomain();
      return Right(updatedPost);
    } on supabase.PostgrestException catch (e) {
      switch (e.message) {
        case 'Insufficient coins':
          // show not enough coins UI
          return const Left(Failure.custom('Not enough coins to claim this post.'));
        case 'Post already claimed':
          // handle already claimed
          return const Left(Failure.custom('This post has already been claimed.'));
        case 'Unauthorized':
          // handle auth error
          return const Left(Failure.custom('You need to be logged in to claim a post.'));
        default:
          {
            logger.e('Supabase error while claiming post: ${e.message}');
            return Left(InfraExceptions.exceptionToFailure(e));
          }
      }
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }

  @override
  AsyncFailT<List<Post>> fetchPosts(FetchPostsParams params) async {
    try {
      final profileId = await _cacheStorage.read<int>(key: AuthCacheKeys.userProfileId);

      final postsJson = await _supabaseClient.rpc<List<Map<String, dynamic>>>(
        'get_posts_with_rls',
        params: {
          'p_profile_id': profileId,
          'p_limit': params.limit,
          'p_offset': params.skip,
        },
      );

      final posts = postsJson.map((json) => PostModel.fromJson(json).toDomain()).toList();

      return Right(posts);
    } on Exception catch (e) {
      return Left(InfraExceptions.exceptionToFailure(e));
    }
  }
}
