import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/profile_selection/profile_selection.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Usecase for setting the last used user profile.
@singleton
class SetLastUsedUserProfile implements Usecase<Unit, UserProfile> {
  /// constructor
  const SetLastUsedUserProfile(this._repository);

  final IProfileSelectionRepository _repository;

  @override
  AsyncFailT<Unit> call(UserProfile params) {
    return _repository.setLastUsedUserProfile(params);
  }
}
