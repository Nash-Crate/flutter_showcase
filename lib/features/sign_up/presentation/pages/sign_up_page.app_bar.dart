part of 'sign_up_page.dart';

/// SignUp page app bar
class SignUpPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// constructor
  const SignUpPageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('SignUp'),
    );
  }
}
