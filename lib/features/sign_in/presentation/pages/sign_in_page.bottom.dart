part of 'sign_in_page.dart';

/// SignIn page middle section
class SignInPageBottomNav extends StatelessWidget {
  /// constructor
  const SignInPageBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('OR'),
          TextButton(
            onPressed: () => context.push(const SignUpRoute().location),
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
