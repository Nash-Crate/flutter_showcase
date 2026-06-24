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

    unawaited(_splashProcess());
  }

  /// checks the authentication state and navigates to the appropriate page.
  Future<void> _splashProcess() async {
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
              ? context.go(intendedPath)
              : (authState.userProfile == null
                    ? const ProfileSelectionRoute().go(context)
                    : const PostsRoute().go(context));
        } else if (authState is Unauthenticated) {
          // stop the checker loop
          flag = false;
          return context.go(intendedPath ?? const SignInRoute().location);
        }

        await Future<void>.delayed(const Duration(milliseconds: 200));
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
