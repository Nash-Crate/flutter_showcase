import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/profile/profile.dart';
import 'package:injectable/injectable.dart';

/// Repository for posts
@Singleton(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  /// Constructor
  const ProfileRepository(this._datasource);

  final ProfileDatasource _datasource;

  @override
  StreamFailT<double> watchProfileCoins() {
    return _datasource.watchProfileCoins();
  }

  @override
  AsyncFailT<double> getUserCoins() {
    return _datasource.getUserCoins();
  }
}
