import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/posts/posts.dart';
import 'package:go_router/go_router.dart';

part 'home_page.app_bar.dart';

part 'home_page.bottom.dart';

/// The home page of the app.
class HomePageWrapper extends StatelessWidget {
  /// constructor
  const HomePageWrapper({required this.navigationShell, required this.children, super.key});

  /// The navigation shell that manages the state of the bottom navigation bar and its branches.
  final StatefulNavigationShell navigationShell;

  /// The list of branch navigators, kept alive in an IndexedStack.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Nashcrate Flutter Showcase')),
      body: IndexedStack(
        index: navigationShell.currentIndex,
        children: children,
      ),
      bottomNavigationBar: HomePageBottom(navigationShell: navigationShell),
    );
  }
}
