import 'package:flutter/material.dart';

import '../../Custom_colors.dart';

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: ColorsManager.primary,
  onPrimary: ColorsManager.primaryForeground,
  secondary: ColorsManager.secondary,
  onSecondary: ColorsManager.foregroundDark,
  error: ColorsManager.destructive,
  onError: ColorsManager.backgroundDark,
  surface: ColorsManager.backgroundDark,
  onSurface: ColorsManager.foregroundDark,
  outline: ColorsManager.foregroundDark,
  inverseSurface: ColorsManager.foregroundDark,
  onInverseSurface: ColorsManager.backgroundDark,
);
