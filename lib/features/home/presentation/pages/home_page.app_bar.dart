part of 'home_page.dart';

/// The app bar for the home page.
class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// constructor
  const HomePageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final user = (state as Authenticated).userProfile!;

          return Text('Welcome, ${user.name}!');
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            child: const Icon(Icons.logout),
            onTap: () async {
              await showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: context.read<AuthCubit>().signOut,
                      child: const Text('Logout', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
