import 'package:flutter/widgets.dart';
import 'package:flutter_showcase/features/home/home.dart';
import 'package:flutter_showcase/features/sign_in/sign_in.dart';
import 'package:flutter_showcase/features/sign_up/sign_up.dart';
import 'package:flutter_showcase/features/splash/splash.dart';
import 'package:go_router/go_router.dart';

part 'app_routes.g.dart';

// paths
/// The path for home page
const homePath = '/home';

/// The path for SignIn page
const signInPath = '/sign_in';

/// The path for SignUp page
const signUpPath = '/sign_up';

/// The path for splash page
const splashPath = '/splash';

/// home page route
@TypedGoRoute<HomeRoute>(path: homePath)
class HomeRoute extends GoRouteData with $HomeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

/// login page route
@TypedGoRoute<SignInRoute>(path: signInPath)
class SignInRoute extends GoRouteData with $SignInRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInPage();
}

/// sign up page route
@TypedGoRoute<SignUpRoute>(path: signUpPath)
class SignUpRoute extends GoRouteData with $SignUpRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const SignUpPage();
}

/// splash page route
@TypedGoRoute<SplashRoute>(path: splashPath)
class SplashRoute extends GoRouteData with $SplashRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashPage();
}
