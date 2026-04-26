part of 'posts_page.dart';

/// The floating action button of the posts page.
class PostsPageFab extends StatelessWidget {
  /// constructor
  const PostsPageFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Add new Post',
      onPressed: () {
        showInfoNotification('FAB pressed!');
      },
      child: const Icon(Icons.add),
    );
  }
}
