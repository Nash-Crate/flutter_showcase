import 'package:flutter_showcase/core/types/type_defs.dart';
import 'package:flutter_showcase/core/usecases/usecase.dart';
import 'package:flutter_showcase/features/sign_in/sign_in.dart';
import 'package:injectable/injectable.dart';

/// Usecase for getting the user profile.
@singleton
class GetLastUsedUserProfile implements UsecaseNoParams<UserProfile> {
  /// constructor
  const GetLastUsedUserProfile(this._repository);

  final ISignInRepository _repository;

  @override
  AsyncFailT<UserProfile> call() {
    return _repository.getLastUsedUserProfile();
  }
}
