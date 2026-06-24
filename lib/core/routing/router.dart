import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/posts/posts.dart';
import 'package:flutter_showcase/features/profile_selection/profile_selection.dart';
import 'package:flutter_showcase/features/sign_in/sign_in.dart';
import 'package:flutter_showcase/features/sign_up/sign_up.dart';
import 'package:flutter_showcase/features/splash/splash.dart';
import 'package:flutter_showcase/injection.dart';
import 'package:flutter_showcase/logger.dart';
import 'package:go_router/go_router.dart';

part 'go_router_refresh_stream.dart';
part 'router.g.dart';
part 'router_transition.dart';
part 'routes.dart';

/// navigator key for the root navigator
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

// bool _isFirstLoad = true;

/// GoRouter configuration
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  refreshListenable: GoRouterRefreshStream(getIt<AuthCubit>().stream),
  redirect: (context, state) {
    final auth = getIt<AuthCubit>().state;
    final loc = state.matchedLocation;
    final onAuthPages = loc == '/sign-in' || loc == '/sign-up';

    return switch (auth) {
      Processing() => loc == '/splash' ? null : '/splash',
      Unauthenticated() => onAuthPages ? null : '/sign-in',
      Authenticated(:final userProfile) => userProfile == null ? '/profile-selection' : '/posts',
    };
  },
  routes: $appRoutes,
  errorBuilder: (context, state) {
    logger.e(state.error);
    return Scaffold(body: Center(child: Text(state.error.toString())));
  },
);
