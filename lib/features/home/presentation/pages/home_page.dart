import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/home/home.dart';
import 'package:flutter_showcase/injection.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'home_page.app_bar.dart';
part 'home_page.bottom.dart';
part 'home_page.content.dart';
part 'home_page.fab.dart';

/// The home page of the app.
class HomePage extends StatefulWidget {
  /// constructor
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  bool _isFabVisible = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    // fetch posts if already in the Authenticated state
    if (context.read<AuthCubit>().state is Authenticated) {
      unawaited(context.read<HomeCubit>().fetchPosts(isInit: true));
    }
  }

  void _onScroll() {
    final isScrollingDown =
        _scrollController.position.userScrollDirection == ScrollDirection.reverse;
    final isScrollingUp = _scrollController.position.userScrollDirection == ScrollDirection.forward;

    if (isScrollingDown && _isFabVisible) {
      setState(() => _isFabVisible = false);
    } else if (isScrollingUp && !_isFabVisible) {
      setState(() => _isFabVisible = true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Fetch posts when the user is authenticated
          unawaited(context.read<HomeCubit>().fetchPosts(isInit: true));
        } else if (state is Unauthenticated) {
          context.pushReplacement(SignInRoute().location);
        }
      },
      builder: (context, state) {
        if (state is! Authenticated || state.userProfile == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: const Color.fromRGBO(205, 205, 205, 1),
          appBar: const HomePageAppBar(),
          body: HomePageContent(scrollController: _scrollController),
          bottomNavigationBar: const HomePageBottom(),
          floatingActionButton: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _isFabVisible ? 1 : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isFabVisible ? 1.0 : 0.0,
              child: const HomePageFab(),
            ),
          ),
        );
      },
    );
  }
}
