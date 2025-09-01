import 'package:flutter/material.dart';

class GameColors extends ThemeExtension<GameColors> {
  final Color posCorrectColor;
  final Color posWrongColor;
  final Color notInWordColor;

  const GameColors({required this.posCorrectColor, required this.posWrongColor, required this.notInWordColor});
  @override
  ThemeExtension<GameColors> copyWith({Color? posCorrectColor, Color? posWrongColor, Color? notInWordColor}) {
    return GameColors(
      posCorrectColor: posCorrectColor ?? this.posCorrectColor,
      posWrongColor: posWrongColor ?? this.posWrongColor,
      notInWordColor: notInWordColor ?? this.notInWordColor,
    );
  }

  @override
  ThemeExtension<GameColors> lerp(covariant ThemeExtension<GameColors>? other, double t) {
    if (other is! GameColors) {
      return this;
    }

    return GameColors(
      posCorrectColor: Color.lerp(posCorrectColor, other.posCorrectColor, t) ?? posCorrectColor,
      posWrongColor: Color.lerp(posWrongColor, other.posWrongColor, t) ?? posWrongColor,
      notInWordColor: Color.lerp(notInWordColor, other.notInWordColor, t) ?? notInWordColor,
    );
  }
}
