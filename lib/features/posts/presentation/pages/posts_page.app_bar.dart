part of 'posts_page.dart';

/// The app bar for the posts page.
class PostsPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// constructor
  const PostsPageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: BlocBuilder<PurchasesCubit, PurchasesState>(
        builder: (context, state) {
          if (state.userCoins == null) return const Center(child: CircularProgressIndicator());

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You have',
                style: TextStyle(fontSize: 8, color: Colors.black),
              ),
              Text(
                '${state.userCoins}',
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Points',
                style: TextStyle(fontSize: 8, color: Colors.black),
              ),
            ],
          );
        },
      ),
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
