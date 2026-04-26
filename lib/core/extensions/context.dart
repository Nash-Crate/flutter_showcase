import 'package:flutter/material.dart';

/// BuildContext extensions
extension BC on BuildContext {
  /// [MediaQuery]
  MediaQueryData get mq => MediaQuery.of(this);

  /// [Theme]
  ThemeData get theme => Theme.of(this);

  /// [TextTheme]
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// [ColorScheme]
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// returns true if the text direction is left for the active Locale
  bool get isLTR => Directionality.of(this) == TextDirection.ltr;
}
