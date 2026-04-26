part of 'posts_page.dart';

/// The bottom navigation bar of the posts page.
class PostsPageBottom extends StatelessWidget {
  /// constructor
  const PostsPageBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.feed),
          label: 'Feed',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.search),
        //   label: 'Search',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
