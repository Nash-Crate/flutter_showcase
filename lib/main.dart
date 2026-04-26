import 'package:flutter/material.dart';
import 'package:flutter_showcase/app.dart';
import 'package:flutter_showcase/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // /// Use path URL strategy for web to remove the hash from the URL.
  // usePathUrlStrategy();
  // GoRouter.optionURLReflectsImperativeAPIs = true;

  // // flutter bloc observer initialization
  // Bloc.observer = MainBlocObserver();

  // injectable library initialization
  await configureDependencies();

  runApp(const App());
}
