import 'package:flutter_showcase/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Dependency injection container
final GetIt getIt = GetIt.instance;

/// Initialize dependency injection
@injectableInit
Future<void> configureDependencies() async => getIt.init();
