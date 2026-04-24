part of 'sign_up_page.dart';

/// SignUp page bottom section
class SignUpPageBottom extends StatelessWidget {
  /// constructor
  const SignUpPageBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Go back to'),
          TextButton(
            onPressed: context.pop,
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
