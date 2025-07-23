import 'package:flutter/material.dart';

import '../../constants.dart';
import '../Custom_colors.dart';
import 'Input_border.dart';
import 'themes/dark_theme_schema.dart';
import 'themes/light_theme_schema.dart';

class AppThemes {
  static ThemeData lightTheme() {
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
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: darkColorScheme,
      scaffoldBackgroundColor: ColorsManager.backgroundDark,
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.radiusSM),
          borderSide: BorderSide(color: ColorsManager.borderDark),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Constants.paddingSM,
          vertical: Constants.paddingMD,
        ),
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
