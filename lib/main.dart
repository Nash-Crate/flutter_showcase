import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/app.dart';
import 'package:flutter_showcase/bloc_observer.dart';
import 'package:flutter_showcase/injection.dart';
import 'package:go_router/go_router.dart';
// for web URL strategy - import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Use path URL strategy for web to remove the hash from the URL.
  // if (kIsWeb) usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // flutter bloc observer initialization
  Bloc.observer = MainBlocObserver();

  // injectable library initialization
  await configureDependencies();

  runApp(const App());
}
