import 'package:flutter_showcase/core/core.dart';
import 'package:injectable/injectable.dart';

/// Usecase for fetching the last used user profile from the local storage.
@singleton
class GetLastUsedUserProfile implements UsecaseNoParams<UserProfile> {
  /// Constructor
  const GetLastUsedUserProfile(this._repository);

  final IAuthRepository _repository;

  @override
  AsyncFailT<UserProfile> call() {
    return _repository.getLastUsedUserProfile();
  }
}
