import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/profile_selection/profile_selection.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Repository for managing user profile selection
@Singleton(as: IProfileSelectionRepository)
class ProfileSelectionRepository implements IProfileSelectionRepository {
  /// Constructor
  const ProfileSelectionRepository(this._dataSource);

  final ProfileSelectionDataSource _dataSource;

  @override
  AsyncFailT<List<UserProfile>> getUserProfiles() {
    return _dataSource.getUserProfiles();
  }

  @override
  AsyncFailT<Unit> setLastUsedUserProfile(UserProfile profile) {
    return _dataSource.setLastUsedUserProfile(profile);
  }
}
