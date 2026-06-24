import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/home/home.dart';
import 'package:flutter_showcase/features/post_details/post_details.dart';
import 'package:flutter_showcase/features/posts/posts.dart';
import 'package:flutter_showcase/features/profile/profile.dart';
import 'package:flutter_showcase/features/profile_selection/profile_selection.dart';
import 'package:flutter_showcase/features/search/search.dart';
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
  // initialLocation: '/',
  refreshListenable: GoRouterRefreshStream(getIt<AuthCubit>().stream),
  redirect: (context, state) {
    final auth = getIt<AuthCubit>().state;
    final loc = state.matchedLocation;

    const splash = '/splash';
    const profileSelection = '/profile-selection';

    final onSplash = loc == splash;
    final onAuthPages = loc == '/sign-in' || loc == '/sign-up';

    switch (auth) {
      case Processing():
        // still validating the session — hold on splash
        return onSplash ? null : splash;

      case Unauthenticated():
        // allow the sign-in / sign-up pages, otherwise force sign-in
        return onAuthPages ? null : '/sign-in';

      case Authenticated(:final userProfile):
        // signed in but no active profile yet — must pick one first
        if (userProfile == null) {
          return loc == profileSelection ? null : profileSelection;
        }
        // fully authed: only bounce off splash/auth pages into the app,
        // otherwise allow the requested in-app route through
        if (onSplash || onAuthPages) return '/posts';
        return null;
    }
  },
  routes: $appRoutes,
  errorBuilder: (context, state) {
    logger.e(state.error);
    return Scaffold(body: Center(child: Text(state.error.toString())));
  },
);
