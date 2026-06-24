part of 'router.dart';

// part 'routes.g.dart';

// /// app router
// final GoRouter router = GoRouter(
//   initialLocation: '/home',
//   routes: $appRoutes,
// );

/// main shell route data
@TypedStatefulShellRoute<MainShellRouteData>(
  branches: [
    TypedStatefulShellBranch<PostsBranchData>(
      routes: [
        TypedGoRoute<PostsRoute>(
          path: '/posts',
          // routes: [
          //   TypedGoRoute<PostDetailRoute>(path: 'detail/:id'),
          // ],
        ),
      ],
    ),
    TypedStatefulShellBranch<ProfileSelectionBranchData>(
      routes: [
        TypedGoRoute<ProfileSelectionRoute>(path: '/profile-selection'),
      ],
    ),
    // TypedStatefulShellBranch<SearchBranchData>(
    //   routes: [
    //     TypedGoRoute<SearchRoute>(path: '/search'),
    //   ],
    // ),
    // TypedStatefulShellBranch<ProfileBranchData>(
    //   routes: [
    //     TypedGoRoute<ProfileRoute>(path: '/profile'),
    //   ],
    // ),
  ],
)
class MainShellRouteData extends StatefulShellRouteData {
  /// constant constructor
  const MainShellRouteData();

  /// The generator wires this static into StatefulShellRoute.indexedStack.
  /// `children` are the branch navigators, kept alive in an IndexedStack.
  static Widget $navigatorContainerBuilder(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) {
    return ScaffoldWithNavBar(
      navigationShell: navigationShell,
      children: children,
    );
  }

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return navigationShell;
  }
}

/// The branch data for the profile selection branch.
class ProfileSelectionBranchData extends StatefulShellBranchData {
  /// constant constructor
  const ProfileSelectionBranchData();
}

/// The branch data for the posts branch.
class PostsBranchData extends StatefulShellBranchData {
  ///  constant constructor
  const PostsBranchData();
}

// class SearchBranchData extends StatefulShellBranchData {
//   const SearchBranchData();
// }
//
// class ProfileBranchData extends StatefulShellBranchData {
//   const ProfileBranchData();
// }

// ------------------------
// Routes

/// Splash — entry point, decides where to send the user.
@TypedGoRoute<SplashRoute>(path: '/splash')
class SplashRoute extends GoRouteData with $SplashRoute {
  /// constructor
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashPage();
}

/// Sign in.
@TypedGoRoute<SignInRoute>(path: '/sign-in')
class SignInRoute extends GoRouteData with $SignInRoute {
  /// constructor
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInPage();
}

/// Sign up.
@TypedGoRoute<SignUpRoute>(path: '/sign-up')
class SignUpRoute extends GoRouteData with $SignUpRoute {
  /// constructor
  const SignUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignUpPage();
}

/// The route data class for the profile selection route.
class ProfileSelectionRoute extends GoRouteData with $ProfileSelectionRoute {
  /// constructor
  const ProfileSelectionRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileSelectionPage();
  }
}

/// The route data class for the home branch.
class PostsRoute extends GoRouteData with $PostsRoute {
  /// constructor
  const PostsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const PostsPage();
}

// /// The route data class for the home detail route.
// class PostDetailRoute extends GoRouteData with $PostDetailRoute {
//   /// constructor
//   const PostDetailRoute({required this.id});
//
//   /// The id of the post to display.
//   final String id;
//
//   @override
//   Widget build(BuildContext context, GoRouterState state) => PostDetailPage(id: id);
// }

// /// The route data class for the profile route
// class ProfileRoute extends GoRouteData with $ProfileRoute {
//   /// constructor
//   const ProfileRoute();
//
//   @override
//   Widget build(BuildContext context, GoRouterState state) => const ProfileScreen();
// }
