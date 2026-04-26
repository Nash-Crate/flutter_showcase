import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/profile_selection/profile_selection.dart';
import 'package:injectable/injectable.dart';

/// Usecase for fetching the user profiles for the authenticated user.
@singleton
class GetUserProfiles implements UsecaseNoParams<List<UserProfile>> {
  /// constructor
  const GetUserProfiles(this._repository);

  final IProfileSelectionRepository _repository;

  @override
  AsyncFailT<List<UserProfile>> call() {
    return _repository.getUserProfiles();
  }
}
