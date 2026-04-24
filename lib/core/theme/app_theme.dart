import 'package:flutter/material.dart';

part 'app_colors.dart';

final ThemeData _baseLightTheme = ThemeData.light();
final ThemeData _baseDarkTheme = ThemeData.dark();

/// Light theme
final ThemeData lightTheme = _baseLightTheme.copyWith(
  brightness: Brightness.light,
);

/// Dark theme
// TODO(darkTheme): add dark theme.
final ThemeData darkTheme = _baseDarkTheme.copyWith(
  brightness: Brightness.dark,
);
