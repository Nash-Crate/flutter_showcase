import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/core/extensions/extensions.dart';
import 'package:flutter_showcase/features/profile_selection/profile_selection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'profile_selection_state.dart';
part 'profile_selection_cubit.freezed.dart';

/// Cubit for managing the state of profile selection in the application.
@injectable
class ProfileSelectionCubit extends Cubit<ProfileSelectionState> {
  /// Initializes the cubit with the initial state.
  ProfileSelectionCubit(this._getUserProfiles, this._setLastUsedUserProfile)
    : super(ProfileSelectionState.initial()) {
    unawaited(getUserProfiles());
  }

  final GetUserProfiles _getUserProfiles;
  final SetLastUsedUserProfile _setLastUsedUserProfile;

  /// Fetches the user profiles.
  Future<void> getUserProfiles() async {
    emit(state.copyWith(profiles: null));

    final res = await _getUserProfiles();
    if (res.isLeft()) return addError(res.asL);

    return emit(state.copyWith(profiles: res.asR));
  }

  /// Selects a user profile.
  Future<void> selectProfile(UserProfile profile) async {
    // cache the selected profile as the last used profile
    final res = await _setLastUsedUserProfile(profile);

    if (res.isLeft()) return addError(res.asL);
  }
}
