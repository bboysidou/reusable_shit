import 'package:flutter/material.dart';

import '../../constants.dart';
import '../Custom_colors.dart';
import 'Input_border.dart';

class AppThemes {
  static ThemeData lightTheme() {
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

    return ThemeData(
      brightness: Brightness.light,
      colorScheme: lightColorScheme,
      scaffoldBackgroundColor: ColorsManager.background,
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorsManager.input,
        contentPadding: const EdgeInsets.all(Constants.paddingSM),
        enabledBorder: InputBorderConstant.borderTheme(
          color: ColorsManager.border,
        ),
        focusedBorder: InputBorderConstant.borderTheme(
          color: ColorsManager.primary,
        ),
        errorBorder: InputBorderConstant.borderTheme(
          color: ColorsManager.destructive,
        ),
        focusedErrorBorder: InputBorderConstant.borderTheme(
          color: ColorsManager.destructive,
        ),
        disabledBorder: InputBorderConstant.borderTheme(
          color: ColorsManager.muted,
        ),
      ),
      textTheme: Typography.material2021().black.apply(
        bodyColor: ColorsManager.foreground,
        displayColor: ColorsManager.foreground,
      ),
    );
  }

  static ThemeData darkTheme() {
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
      outline: ColorsManager.borderDark,
      inverseSurface: ColorsManager.foregroundDark,
      onInverseSurface: ColorsManager.backgroundDark,
    );

    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: darkColorScheme,
      scaffoldBackgroundColor: ColorsManager.backgroundDark,
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorsManager.inputDark,
        contentPadding: const EdgeInsets.all(Constants.paddingSM),
        enabledBorder: InputBorderConstant.borderTheme(
          color: ColorsManager.borderDark,
        ),
        focusedBorder: InputBorderConstant.borderTheme(
          color: ColorsManager.primary,
        ),
        errorBorder: InputBorderConstant.borderTheme(
          color: ColorsManager.destructive,
        ),
        focusedErrorBorder: InputBorderConstant.borderTheme(
          color: ColorsManager.destructive,
        ),
        disabledBorder: InputBorderConstant.borderTheme(
          color: ColorsManager.muted,
        ),
      ),
      textTheme: Typography.material2021().white.apply(
        bodyColor: ColorsManager.foregroundDark,
        displayColor: ColorsManager.foregroundDark,
      ),
    );
  }
}
