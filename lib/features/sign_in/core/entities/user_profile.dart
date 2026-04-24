import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

/// Entity class representing a user in the authentication system.
@freezed
abstract class UserProfile with _$UserProfile {
  /// constructor
  const factory UserProfile({
    required int id,
    required String name,
  }) = _UserProfile;
}
