import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';

part 'auth_cubit.freezed.dart';

/// Cubit for authentication state management.
@singleton
class AuthCubit extends Cubit<AuthState> {
  /// constructor
  AuthCubit(this._checkAuth, this._signOutUser, this._getLastUsedUserProfile)
    : super(const Processing()) {
    unawaited(checkAuth());
  }

  final CheckAuth _checkAuth;
  final SignOutUser _signOutUser;
  final GetLastUsedUserProfile _getLastUsedUserProfile;

  /// Checks the authentication status of the user.
  Future<void> checkAuth() async {
    emit(const Processing());

    final checkAuthRes = await _checkAuth();
    if (checkAuthRes.isLeft()) {
      addError(checkAuthRes.asL);
      return emit(const Unauthenticated());
    }

    if (!checkAuthRes.asR) {
      // no previous session found
      return emit(const Unauthenticated());
    }

    final profileRes = await _getLastUsedUserProfile();
    if (profileRes.isLeft()) {
      addError(profileRes.asL);
      return emit(const Unauthenticated());
    }

    return emit(Authenticated(userProfile: profileRes.asR));
  }

  /// Sign out the user.
  Future<dynamic> signOut() async {
    emit(const Processing());

    final res = await _signOutUser();
    if (res.isLeft()) addError(res.asL);

    emit(const Unauthenticated());
  }

  /// Sets the user profile in the state.
  void setUserProfile(UserProfile userProfile) {
    if (state is! Authenticated) {
      addError('Cannot set user profile when not authenticated');
      return;
    }

    emit(Authenticated(userProfile: userProfile));
  }

  /// Called when the user has successfully signed in.
  void signInSuccess() {
    emit(const Authenticated());
  }

  /// Sets the active profile for the user.
  void setActiveProfile(UserProfile profile) {
    if (state is! Authenticated) {
      addError('Cannot set active profile when not authenticated');
      return;
    }

    emit(Authenticated(userProfile: profile));
  }
}
