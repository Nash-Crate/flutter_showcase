import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/logger.dart';
import 'package:go_router/go_router.dart';

/// navigator key
final navigatorKey = GlobalKey<NavigatorState>();

bool _isFirstLoad = true;

/// GoRouter configuration
final appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: SplashRoute().location,
  observers: [BotToastNavigatorObserver()],
  redirect: (context, state) {
    if (_isFirstLoad) {
      _isFirstLoad = false;
      final isSplash = state.matchedLocation == SplashRoute().location;

      if (isSplash) return null;

      // Preserve the intended URL as a query param
      final intended = state.uri.toString();
      return '${SplashRoute().location}?from=${Uri.encodeComponent(intended)}';
    }
    return null;
  },
  routes: $appRoutes,
  errorBuilder: (context, state) {
    logger.e(state.error);
    return Scaffold(body: Center(child: Text(state.error.toString())));
  },
);
