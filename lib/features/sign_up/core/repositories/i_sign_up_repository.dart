import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/sign_up/sign_up.dart';
import 'package:fpdart/fpdart.dart';

/// Interface for SignUp repository
mixin ISignUpRepository {
  /// Sign up with email and password
  AsyncFailT<Unit> signUpWithEmailAndPassword(EmailSignUpDto dto);
}
