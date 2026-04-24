import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/extensions/extensions.dart';
import 'package:flutter_showcase/features/sign_in/sign_in.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';

part 'auth_cubit.freezed.dart';

/// Cubit for authentication state management.
@singleton
class AuthCubit extends Cubit<AuthState> {
  /// constructor
  AuthCubit(
    this._checkAuth,
    this._signOutUser,
    this._getLastUsedUserProfile,
    this._getUserProfiles,
  ) : super(const Processing()) {
    unawaited(checkAuth());
  }

  final CheckAuth _checkAuth;
  final SignOutUser _signOutUser;
  final GetLastUsedUserProfile _getLastUsedUserProfile;
  final GetUserProfiles _getUserProfiles;

  /// Checks the authentication status of the user.
  Future<void> checkAuth() async {
    emit(const Processing());

    final checkAuthRes = await _checkAuth();
    if (checkAuthRes.isLeft()) {
      addError(checkAuthRes.asL);
      return emit(const Unauthenticated());
    }

    final profileRes = await _getLastUsedUserProfile();
    if (profileRes.isLeft()) {
      addError(profileRes.asL);
      return emit(const Unauthenticated());
    }

    return emit(Authenticated1(profileRes.asR));
  }

  /// Fetches the user profiles.
  Future<void> getUserProfiles() async {
    if (state is! PartiallyAuthenticated) return;

    emit(const PartiallyAuthenticated(isProcessing: true, profiles: null));

    final res = await _getUserProfiles();
    if (res.isLeft()) {
      addError(res.asL);
      return emit(const Unauthenticated());
    }

    return emit(PartiallyAuthenticated(isProcessing: false, profiles: res.asR));
  }

  /// Sign out the user.
  Future<dynamic> signOut() async {
    emit(const Processing());

    final res = await _signOutUser();
    if (res.isLeft()) addError(res.asL);

    emit(const Unauthenticated());
  }

  /// Called when the user has successfully signed in.
  void signInSuccess() {
    emit(const PartiallyAuthenticated(isProcessing: false, profiles: null));

    // Fetch user profiles after successful sign-in.
    unawaited(getUserProfiles());
  }

  /// Selects a user profile.
  void selectProfile(UserProfile profile) => emit(Authenticated1(profile));
}
