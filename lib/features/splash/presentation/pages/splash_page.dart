import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:go_router/go_router.dart';

/// A page that displays a splash screen.
class SplashPage extends StatefulWidget {
  /// constructor
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    unawaited(configsChecker());
  }

  /// Wait for the configs to be loaded
  Future<void> configsChecker() async {
    await Future<void>.delayed(const Duration(seconds: 1));

    var flag = true;
    while (flag) {
      if (!flag) return;

      if (mounted) {
        final authState = context.read<AuthCubit>().state;

        final intended = GoRouter.of(context).state.uri.queryParameters['from'];
        final intendedPath = intended != null ? Uri.decodeComponent(intended) : null;

        if (authState is Authenticated) {
          // stop the checker loop
          flag = false;

          return intendedPath != null
              ? context.pushReplacement(intendedPath)
              : (authState.userProfile == null
                    ? ProfileSelectionRoute().pushReplacement(context)
                    : HomeRoute().pushReplacement(context));
        } else if (authState is Unauthenticated) {
          // stop the checker loop
          flag = false;
          return context.pushReplacement(intendedPath ?? SignInRoute().location);
        }

        await Future<void>.delayed(const Duration(milliseconds: 300));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}
