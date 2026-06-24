import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_showcase/core/core.dart';
import 'package:flutter_showcase/features/posts/posts.dart';
import 'package:flutter_showcase/features/profile_selection/profile_selection.dart';
import 'package:flutter_showcase/features/purchases/purchases.dart';
import 'package:flutter_showcase/injection.dart';
import 'package:toastification/toastification.dart';

/// The main application widget.
class App extends StatelessWidget {
  /// Creates an instance of the App widget.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      config: const ToastificationConfig(),
      child: MaterialApp.router(
        builder: (ctx, child) {
          // initialise screenUtil
          ScreenUtil.init(ctx);

          return Theme(
            data: lightTheme,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<AuthCubit>()),
                BlocProvider(create: (context) => getIt<PostsCubit>()),
                BlocProvider(create: (context) => getIt<ProfileSelectionCubit>()),
                BlocProvider(create: (context) => getIt<PurchasesCubit>()),
              ],
              child: Theme(data: lightTheme, child: child!),
            ),
          );
        },
        routerConfig: appRouter,
      ),
    );
  }
}
