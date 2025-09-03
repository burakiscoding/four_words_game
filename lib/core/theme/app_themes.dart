import 'package:flutter/material.dart';
import 'package:four_words_game/core/theme/game_colors.dart';

class AppColors {
  static const Color black = Colors.black;
  static const Color lightOrange = Color(0xffFFD6BA);
  static const Color beige = Color(0xFFFFF2EB);
  static const Color green = Colors.green;
  static const Color orange = Colors.orange;
  static const Color grey = Color(0xFFe1e5e8);
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
    cardColor: AppColors.grey,
    dialogTheme: const DialogThemeData(
      backgroundColor: AppColors.beige,
      contentTextStyle: TextStyle(fontSize: 16, color: AppColors.black, fontFamily: 'Nunito'),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.black,
        textStyle: const TextStyle(fontFamily: 'PermanentMarker', color: AppColors.black, fontSize: 22),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightOrange,
        foregroundColor: AppColors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle: const TextStyle(fontFamily: 'PermanentMarker', color: AppColors.black, fontSize: 22),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.beige,
      titleTextStyle: TextStyle(fontFamily: 'PermanentMarker', color: AppColors.black, fontSize: 22),
      centerTitle: true,
    ),
    colorScheme: const ColorScheme(
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

    buttonTheme: const ButtonThemeData(
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
    dialogTheme: const DialogThemeData(
      backgroundColor: AppColors.beige,
      contentTextStyle: TextStyle(fontSize: 16, color: AppColors.black, fontFamily: 'Nunito'),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.black,
        textStyle: const TextStyle(fontFamily: 'PermanentMarker', color: AppColors.black, fontSize: 22),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightOrange,
        foregroundColor: AppColors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle: const TextStyle(fontFamily: 'PermanentMarker', color: AppColors.black, fontSize: 22),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.beige,
      titleTextStyle: TextStyle(fontFamily: 'PermanentMarker', color: AppColors.black, fontSize: 22),
      centerTitle: true,
    ),
    colorScheme: const ColorScheme(
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

    buttonTheme: const ButtonThemeData(
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
