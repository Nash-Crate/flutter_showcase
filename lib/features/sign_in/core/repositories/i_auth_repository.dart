import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/sign_in/sign_in.dart';
import 'package:fpdart/fpdart.dart';

/// Interface for SignIn repository
mixin ISignInRepository {
  /// Sign in with email and password
  AsyncFailT<Unit> signInWithEmailAndPassword(EmailSignInDto dto);

  /// Sign in with Google
  AsyncFailT<Unit> signInWithGoogle();
}
