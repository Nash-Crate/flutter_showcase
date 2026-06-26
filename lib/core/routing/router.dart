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
    const signIn = '/sign-in';
    const profileSelection = '/profile-selection';

    final onSplash = loc == splash;
    final onAuthPages = loc == signIn || loc == '/sign-up';
    final onProfileSelection = loc == profileSelection;

    // The destination to reach once auth/profile is resolved. Prefer an
    // already-preserved `?from=`, otherwise the current location when it's a
    // real in-app target (not a gate page). This is how a deep link survives
    // the splash -> sign-in -> profile-selection gate.
    var intended = state.uri.queryParameters['from'];
    if (intended == null && !onSplash && !onAuthPages && !onProfileSelection && loc != '/') {
      intended = state.uri.toString();
    }

    // Redirect to [path], carrying the intended destination as `?from=`.
    String withFrom(String path) =>
        intended == null ? path : Uri(path: path, queryParameters: {'from': intended}).toString();

    switch (auth) {
      case Processing():
        // still validating the session — hold on splash, keep the target
        return onSplash ? null : withFrom(splash);

      case Unauthenticated():
        // allow the sign-in / sign-up pages, otherwise force sign-in
        return onAuthPages ? null : withFrom(signIn);

      case Authenticated(:final userProfile):
        // signed in but no active profile yet — must pick one first
        if (userProfile == null) {
          return onProfileSelection ? null : withFrom(profileSelection);
        }
        // fully authed: leave any gate page, honoring the intended destination
        if (onSplash || onAuthPages || onProfileSelection) {
          return intended ?? '/posts';
        }
        return null;
    }
  },
  routes: $appRoutes,
  errorBuilder: (context, state) {
    logger.e(state.error);
    return Scaffold(body: Center(child: Text(state.error.toString())));
  },
);
