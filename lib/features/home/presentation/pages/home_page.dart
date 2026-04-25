import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/logger.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:video_player/video_player.dart';

part 'home_page.app_bar.dart';
part 'home_page.bottom.dart';
part 'home_page.content.dart';

/// The home page of the app.
class HomePage extends StatelessWidget {
  /// constructor
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.pushReplacement(SignInRoute().location);
        }
      },
      builder: (context, state) {
        if (state is! Authenticated || state.userProfile == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return const Scaffold(
          appBar: HomePageAppBar(),
          body: HomePageContent(),
          bottomNavigationBar: HomePageBottom(),
        );
      },
    );
  }
}
