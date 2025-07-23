import 'package:flutter/material.dart';

import '../../Custom_colors.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: ColorsManager.primary,
  onPrimary: ColorsManager.primaryForeground,
  secondary: ColorsManager.secondary,
  onSecondary: ColorsManager.foreground,
  error: ColorsManager.destructive,
  onError: ColorsManager.background,
  surface: ColorsManager.background,
  onSurface: ColorsManager.foreground,
  outline: ColorsManager.border,
  surfaceContainerHighest: ColorsManager.secondary,
  inverseSurface: ColorsManager.foreground,
  onInverseSurface: ColorsManager.background,
);
