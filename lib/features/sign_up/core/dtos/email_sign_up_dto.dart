import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_sign_up_dto.freezed.dart';

/// Data Transfer Object for email registration.
@freezed
abstract class EmailSignUpDto with _$EmailSignUpDto {
  /// constructor
  const factory EmailSignUpDto({
    required String email,
    required String password,
    required String name,
  }) = _EmailSignUpDto;
}
