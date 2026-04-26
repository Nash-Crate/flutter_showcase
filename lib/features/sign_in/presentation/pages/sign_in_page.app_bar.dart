part of 'sign_in_page.dart';

/// SignIn page app bar
class SignInPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// constructor
  const SignInPageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Sign In'),
    );
  }
}
