part of 'home_page.dart';

final List<({IconData icon, String label, String route})> _tabs = [
  (route: const PostsRoute().location, icon: Icons.home, label: 'Posts'),
  (route: const SearchRoute().location, icon: Icons.search, label: 'Search'),
  (route: const ProfileRoute().location, icon: Icons.person, label: 'Profile'),
];

/// The bottom navigation bar of the Home page.
class HomePageBottom extends StatelessWidget {
  /// constructor
  const HomePageBottom({required this.navigationShell, super.key});

  /// The navigation shell that manages the state of the bottom navigation bar and its branches.
  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    // initialLocation: true re-taps return the branch to its root.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: _onTap,
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
