import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/profile_selection/presentation/blocs/blocs.dart';
import 'package:flutter_showcase/features/sign_in/sign_in.dart';
import 'package:flutter_showcase/injection.dart';
import 'package:go_router/go_router.dart';

part 'sign_in_page.app_bar.dart';
part 'sign_in_page.bottom.dart';
part 'sign_in_page.content.dart';

/// The SignIn page of the app.
class SignInPage extends StatelessWidget {
  /// constructor
  const SignInPage({super.key});

  /// on login state changed
  void onLoginStateChanged(BuildContext context, SignInState state) {
    if (state.result != null && state.result!.isRight()) {
      // Notify the AuthCubit about the successful sign-in.
      context.read<AuthCubit>().signInSuccess();
      // Fetch user profiles after successful sign-in.
      unawaited(context.read<ProfileSelectionCubit>().getUserProfiles());

      // Navigate to the profile selection page after successful login
      context.pushReplacement(const ProfileSelectionRoute().location);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignInCubit>(),
      child: Builder(
        builder: (context) {
          return BlocListener<SignInCubit, SignInState>(
            listenWhen: (previous, current) => previous.result != current.result,
            listener: onLoginStateChanged,
            child: const Scaffold(
              appBar: SignInPageAppBar(),
              body: SafeArea(child: SignInPageContent()),
              bottomNavigationBar: SignInPageBottomNav(),
            ),
          );
        },
      ),
    );
  }
}
