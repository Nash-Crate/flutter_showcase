import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/posts/posts.dart';
import 'package:flutter_showcase/injection.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'posts_page.content.dart';
part 'posts_page.fab.dart';

/// The posts page of the app.
class PostsPage extends StatefulWidget {
  /// constructor
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _scrollController = ScrollController();
  bool _isFabVisible = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    // fetch posts if already in the Authenticated state
    if (context.read<AuthCubit>().state is Authenticated) {
      unawaited(context.read<PostsCubit>().fetchPosts(isInit: true));
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
          unawaited(context.read<PostsCubit>().fetchPosts(isInit: true));
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
          body: PostsPageContent(scrollController: _scrollController),
          floatingActionButton: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _isFabVisible ? 1 : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isFabVisible ? 1.0 : 0.0,
              child: const PostsPageFab(),
            ),
          ),
        );
      },
    );
  }
}
