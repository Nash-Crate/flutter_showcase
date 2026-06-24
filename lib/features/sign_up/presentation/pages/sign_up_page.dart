import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/sign_up/sign_up.dart';
import 'package:flutter_showcase/injection.dart';
import 'package:go_router/go_router.dart';

part 'sign_up_page.app_bar.dart';
part 'sign_up_page.bottom.dart';
part 'sign_up_page.content.dart';

/// A page that allows users to sign up for an account.
class SignUpPage extends StatelessWidget {
  /// constructor
  const SignUpPage({super.key});

  /// on state changed
  void onSignUpStateChanged(BuildContext context, SignUpState state) {
    if (state.result != null && state.result!.isRight()) {
      // Show success message
      showSuccessNotification('Sign Up successful, please login.');
      // Navigate back to the login page
      context.pushReplacement(const SignInRoute().location);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignUpCubit>(),
      child: Builder(
        builder: (context) {
          return BlocListener<SignUpCubit, SignUpState>(
            listenWhen: (previous, current) => previous.result != current.result,
            listener: onSignUpStateChanged,
            child: const Scaffold(
              appBar: SignUpPageAppBar(),
              body: SafeArea(child: SignUpPageContent()),
              bottomNavigationBar: SignUpPageBottom(),
            ),
          );
        },
      ),
    );
  }
}
