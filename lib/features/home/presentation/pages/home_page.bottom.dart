part of 'home_page.dart';

final List<({IconData icon, String label, String route})> _tabs = [
  (route: const PostsRoute().location, icon: Icons.search, label: 'Posts'),
  // (route: AccountRoute().location, icon: Icons.person, label: 'Account'),
];

/// The bottom navigation bar of the Home page.
class HomePageBottom extends StatelessWidget {
  /// constructor
  const HomePageBottom({super.key});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = _tabs.indexWhere((t) => location.startsWith(t.route));
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    // final currentPath = GoRouterState.of(context).uri;

    // late final int currentIndex;
    // if (PostsRoute().location == currentPath.path) {
    //   currentIndex = 0;
    // } else if (AccountRoute().location == currentPath.path) {
    //   currentIndex = 1;
    // } else {
    //   currentIndex = 0;
    // }

    // return BottomNavigationBar(
    //   currentIndex: currentIndex,
    //   onTap: (index) {
    //     switch (index) {
    //       case 0:
    //         context.go(PostsRoute().location);
    //       case 1:
    //         context.go(AccountRoute().location);
    //     }
    //   },
    //   items: const [
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.feed),
    //       label: 'Feed',
    //     ),
    //     // BottomNavigationBarItem(
    //     //   icon: Icon(Icons.search),
    //     //   label: 'Search',
    //     // ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.person),
    //       label: 'Profile',
    //     ),
    //   ],
    // );

    return NavigationBar(
      selectedIndex: _currentIndex(context),
      onDestinationSelected: (index) => context.go(_tabs[index].route),
      destinations: _tabs
          .map(
            (t) => NavigationDestination(
              icon: Icon(t.icon),
              label: t.label,
            ),
          )
          .toList(),
    );
  }
}
