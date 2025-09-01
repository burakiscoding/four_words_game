import 'package:flutter/material.dart';
import 'package:four_words_game/core/theme/game_colors.dart';

class AppColors {
  static const Color black = Colors.black;
  static const Color lightOrange = Color(0xffFFD6BA);
  static const Color beige = Color(0xFFFFF2EB);
  static const Color green = Colors.green;
  static const Color orange = Colors.orange;
}

class AppThemes {
  static const GameColors _gameColors = GameColors(
    posCorrectColor: AppColors.green,
    posWrongColor: AppColors.orange,
    notInWordColor: AppColors.black,
  );

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.lightOrange,
    scaffoldBackgroundColor: AppColors.beige,
    fontFamily: 'Nunito',
    extensions: <ThemeExtension<dynamic>>[_gameColors],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightOrange,
        foregroundColor: AppColors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle: TextStyle(fontFamily: 'PermanentMarker', color: AppColors.black, fontSize: 22),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.beige,
      titleTextStyle: TextStyle(fontFamily: 'PermanentMarker', color: AppColors.black, fontSize: 22),
      centerTitle: true,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.lightOrange,
      onPrimary: AppColors.black,
      secondary: AppColors.lightOrange,
      onSecondary: AppColors.black,
      error: AppColors.lightOrange,
      onError: AppColors.black,
      surface: AppColors.lightOrange,
      onSurface: AppColors.black,
    ),

    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.lightOrange,
        onPrimary: AppColors.black,
        secondary: AppColors.lightOrange,
        onSecondary: AppColors.black,
        error: AppColors.lightOrange,
        onError: AppColors.black,
        surface: AppColors.lightOrange,
        onSurface: AppColors.black,
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.lightOrange,
    scaffoldBackgroundColor: AppColors.beige,
    fontFamily: 'Nunito',
    extensions: <ThemeExtension<dynamic>>[_gameColors],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightOrange,
        foregroundColor: AppColors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle: TextStyle(fontFamily: 'PermanentMarker', color: AppColors.black, fontSize: 22),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.beige,
      titleTextStyle: TextStyle(fontFamily: 'PermanentMarker', color: AppColors.black, fontSize: 22),
      centerTitle: true,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.lightOrange,
      onPrimary: AppColors.black,
      secondary: AppColors.lightOrange,
      onSecondary: AppColors.black,
      error: AppColors.lightOrange,
      onError: AppColors.black,
      surface: AppColors.lightOrange,
      onSurface: AppColors.black,
    ),

    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.lightOrange,
        onPrimary: AppColors.black,
        secondary: AppColors.lightOrange,
        onSecondary: AppColors.black,
        error: AppColors.lightOrange,
        onError: AppColors.black,
        surface: AppColors.lightOrange,
        onSurface: AppColors.black,
      ),
    ),
  );
}
