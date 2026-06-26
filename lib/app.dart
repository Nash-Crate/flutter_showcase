import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/links/links.dart';
import 'package:flutter_showcase/features/notifications/notifications.dart';
import 'package:flutter_showcase/features/posts/posts.dart';
import 'package:flutter_showcase/features/profile_selection/profile_selection.dart';
import 'package:flutter_showcase/features/purchases/purchases.dart';
import 'package:flutter_showcase/injection.dart';
import 'package:flutter_showcase/logger.dart';
import 'package:toastification/toastification.dart';

/// The main application widget.
class App extends StatelessWidget {
  /// Creates an instance of the App widget.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<LinksCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<NotificationsCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<PostsCubit>()),
        BlocProvider(create: (context) => getIt<ProfileSelectionCubit>()),
        BlocProvider(create: (context) => getIt<PurchasesCubit>(), lazy: false),
      ],
      child: ToastificationWrapper(
        config: const ToastificationConfig(),
        child: MaterialApp.router(
          builder: (ctx, child) {
            // initialise screenUtil
            ScreenUtil.init(ctx);

            return Theme(
              data: lightTheme,
              child: Theme(
                data: lightTheme,
                child: Builder(
                  builder: (context) {
                    return BlocListener<LinksCubit, LinksState>(
                      listener: (context, state) {
                        if (state is NewLinkCaptured) {
                          final location = DeepLinkResolver.toLocation(state.link);
                          logger.i('LinksCubit: captured "${state.link}" -> $location');
                          // The router's redirect handles auth-gating; an
                          // unauthenticated user is sent to sign-in with this
                          // location preserved as `?from=`.
                          if (location != null) appRouter.go(location);
                        }
                      },
                      child: child,
                    );
                  },
                ),
              ),
            );
          },
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
