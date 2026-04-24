part of 'profile_selection_cubit.dart';

/// State class for managing the profile selection state in the application.
@freezed
abstract class ProfileSelectionState with _$ProfileSelectionState {
  /// Initial state of the profile selection.
  const factory ProfileSelectionState({
    // if null, processing is still ongoing
    List<UserProfile>? profiles,
  }) = _ProfileSelectionState;

  /// Initial state of the profile selection.
  factory ProfileSelectionState.initial() => const ProfileSelectionState();
}
