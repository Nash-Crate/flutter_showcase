import 'package:flutter/material.dart';

/// A loading screen shown while the auth session is being validated.
///
/// Navigation away from here is driven entirely by the router's `redirect`,
/// which reacts to `AuthCubit` state changes (and preserves any `?from=`
/// deep-link destination).
class SplashPage extends StatelessWidget {
  /// constructor
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}
