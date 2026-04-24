import 'package:flutter_showcase/core/types/type_defs.dart';
import 'package:flutter_showcase/core/usecases/usecase.dart';
import 'package:flutter_showcase/features/sign_in/sign_in.dart';
import 'package:injectable/injectable.dart';

/// Usecase for fetching the user profiles for the authenticated user.
@singleton
class GetUserProfiles implements UsecaseNoParams<List<UserProfile>> {
  /// constructor
  const GetUserProfiles(this._repository);

  final ISignInRepository _repository;

  @override
  AsyncFailT<List<UserProfile>> call() {
    return _repository.getUserProfiles();
  }
}
