import 'package:flutter_showcase/features/sign_in/sign_in.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

part 'user_profile.g.dart';

/// Model class representing a user's profile information.
@freezed
abstract class UserProfileModel with _$UserProfileModel {
  /// constructor
  const factory UserProfileModel({
    required int id,
    required String name,
  }) = _UserProfileModel;

  const UserProfileModel._();

  /// Factory method to create a [UserProfileModel] instance from a JSON map.
  factory UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);

  /// Converts this [UserProfileModel] instance to a [UserProfile] domain entity.
  UserProfile toDomain() {
    return UserProfile(
      id: id,
      name: name,
    );
  }
}
