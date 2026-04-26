import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/home/home.dart';
import 'package:injectable/injectable.dart';

/// Usecase to claim a post
@singleton
class ClaimPost implements Usecase<Post, ClaimPostParams> {
  /// Constructor
  const ClaimPost(this._repository);

  final IPostsRepository _repository;

  @override
  AsyncFailT<Post> call(ClaimPostParams params) {
    return _repository.claimPost(params);
  }
}
