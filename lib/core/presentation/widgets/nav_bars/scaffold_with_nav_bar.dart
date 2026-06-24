import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A Scaffold with a BottomNavigationBar that works with GoRouter's StatefulNavigationShell.
class ScaffoldWithNavBar extends StatelessWidget {
  /// constructor
  const ScaffoldWithNavBar({required this.navigationShell, required this.children, super.key});

  /// The navigation shell that manages the state of the bottom navigation bar and its branches.
  final StatefulNavigationShell navigationShell;

  /// The list of branch navigators, kept alive in an IndexedStack.
  final List<Widget> children;

  void _onTap(int index) {
    // initialLocation: true re-taps return the branch to its root.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack keeps every branch alive and preserves its state/scroll.
      body: IndexedStack(
        index: navigationShell.currentIndex,
        children: children,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
