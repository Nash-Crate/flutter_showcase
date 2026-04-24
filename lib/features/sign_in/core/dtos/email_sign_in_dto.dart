import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_sign_in_dto.freezed.dart';

/// Data Transfer Object for email sign_in, used to encapsulate the data required for email sign_in operations.
@freezed
abstract class EmailSignInDto with _$EmailSignInDto {
  /// constructor
  const factory EmailSignInDto({required String email, required String password}) = _EmailSignInDto;
}
