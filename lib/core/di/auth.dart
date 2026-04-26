import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

/// External library injection for authentication related dependencies.
@module
abstract class AuthExternalLibraryInjectableModule {
  /// Injects GoogleSignIn instance for authentication.
  @preResolve
  Future<GoogleSignIn> googleSignIn() async {
    final instance = GoogleSignIn.instance;
    await instance.initialize(
      serverClientId: const String.fromEnvironment('GoogleClientIdWeb'),
    );
    return instance;
  }
}
