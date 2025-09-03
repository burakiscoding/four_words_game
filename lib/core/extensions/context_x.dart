import 'package:flutter/material.dart';
import 'package:four_words_game/core/theme/game_colors.dart';

extension ContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  GameColors get gameColors => theme.extension<GameColors>()!;
}
