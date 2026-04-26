import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// flag to check if the app is running in test mode
const kTestMode = bool.fromEnvironment('kTestMode');

/// Logger without stack
final logger = Logger(
  // level: kDebugMode ? Level.debug : Level.error,
  level: kTestMode
      ? Level.error
      : kDebugMode
      ? Level.debug
      : Level.error,
  // printer: PrettyPrinter(methodCount: 0),
  printer: PrettyPrinter(methodCount: 0, lineLength: 100),
);
