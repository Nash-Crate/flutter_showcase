import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/posts/posts.dart';
import 'package:go_router/go_router.dart';

part 'home_page.app_bar.dart';
part 'home_page.bottom.dart';

/// The home page of the app.
class HomePage extends StatefulWidget {
  /// constructor
  const HomePage({required this.navigationShell, super.key});

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    PostsPage(),
    // SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    print('MainNavigationShell build, index=$_currentIndex');

    return Scaffold(
      appBar: AppBar(title: const Text('Main Navigation Shell (IndexedStack)')),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  // late final AnimationController _controller;
  // late final Animation<double> _fadeAnimation;
  //
  // static const List<({IconData icon, String label, String path})> _tabs = [
  //   (path: postsPath, icon: Icons.article_outlined, label: 'Posts'),
  //   (path: accountPath, icon: Icons.person_outlined, label: 'Account'),
  // ];
  //
  // int _currentIndex(BuildContext context) {
  //   final location = GoRouterState.of(context).uri.path;
  //   final index = _tabs.indexWhere((t) => location.startsWith(t.path));
  //   return index < 0 ? 0 : index;
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 200),
  //   );
  //   _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  // }
  //
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
  //
  // Future<void> _onTabSelected(int index, BuildContext context) async {
  //   if (index == _currentIndex(context)) {
  //     context.go(_tabs[0].path);
  //     return await _controller.forward();
  //   }
  //
  //   await _controller.reverse().then((_) async {
  //     context.go(_tabs[index].path);
  //     await _controller.forward();
  //   });
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: const HomePageAppBar(),
  //     body: widget.navigationShell,
  //     bottomNavigationBar: NavigationBar(
  //       selectedIndex: _currentIndex(context),
  //       onDestinationSelected: (index) => _onTabSelected(index, context),
  //       destinations: _tabs
  //           .map((t) => NavigationDestination(icon: Icon(t.icon), label: t.label))
  //           .toList(),
  //     ),
  //   );
  // }
}
